@allowed([
  ''
  'demo'
  'stg'
  'sbx'
  'test'
  'dev'
  'qa'
  'uat'
  'prd'
])
@description('The environment in which the resource(s) will be deployed')
param environment string = ''

@description('The region prefix or suffix for the resource name, if applicable.')
param region string = ''

@description('The name of the app configuration')
param appConfigurationName string

@description('The region/location the Azure App Configuration instance will be deployed to.')
param appConfigurationLocation string = resourceGroup().location

@description('The pricing tier for Azure App Configurations: "Free" or "Standard". Default is "Free"')
param appConfigurationSku object = {
  demo: 'Free'
  stg: 'Free'
  sbx: 'Free'
  test: 'Free'
  dev: 'Free'
  qa: 'Free'
  uat: 'Free'
  prd: 'Free'
  default: 'Free'
}

@description('An array of object containing the key, value, and contentType if applicable.')
param appConfigurationKeys array = []

@description('Private endpoint configuration for the app configuration deployment')
param appConfigurationPrivateEndpoint object = {}

@description('Enables Managed System Identity')
param appConfigurationEnableMsi bool = false

@description('The network configuration for the App Configuration resource.')
param appConfigurationNetworkConfig object = {}

@description('Disables local authentication to the app configuration.')
param appConfigurationDisableLocalAuth bool = false

@description('The tags to attach to the resource when deployed')
param appConfigurationTags object = {}

// 1. Deploys a single instance of Azure App Configuration
resource appConfig 'Microsoft.AppConfiguration/configurationStores@2023-09-01-preview' = {
  name: replace(replace(appConfigurationName, '@environment', environment), '@region', region)
  location: appConfigurationLocation
  sku: {
    name: contains(appConfigurationSku, environment) ? appConfigurationSku[environment] : appConfigurationSku.default
  }
  identity: {
    type: appConfigurationEnableMsi == true ? 'SystemAssigned' : 'None'
  }
  properties: {
    disableLocalAuth: appConfigurationDisableLocalAuth
    publicNetworkAccess: contains(appConfigurationNetworkConfig, 'publicNetworkAccess')
      ? appConfigurationNetworkConfig.publicNetworkAccess
      : 'Enabled'
    dataPlaneProxy: {
      authenticationMode: appConfigurationDisableLocalAuth == true ? 'Pass-through' : 'Local'
      privateLinkDelegation: contains(appConfigurationNetworkConfig, 'azureResourceAccess')
        ? appConfigurationNetworkConfig.azureResourceAccess
        : 'Disabled'
    }
  }
  tags: union(appConfigurationTags, {
    region: region
    environment: environment
  })
}

// 2. Deploy any Azure App Configuration Keys and values
module appConfigKeys 'app-configuration-key.bicep' = [
  for (key, index) in appConfigurationKeys: if (!empty(appConfigurationKeys) && appConfigurationDisableLocalAuth == false) {
    name: 'appc-key-${padLeft(index, 3, '0')}-${guid('${appConfig.id}/${key.appConfigurationKey}')}'
    params: {
      region: region
      environment: environment
      appConfigurationName: appConfigurationName
      appConfigurationKey: key.appConfigurationKey
      appConfigurationValue: key.appConfigurationValue
      appConfigurationContentType: key.?appConfigurationContentType
      appConfigurationLabels: key.?appConfigurationLabels
    }
  }
]

// 2. Deploys a private endpoint, if applicable, for an instance of Azure App Configuration
module appConfigPrivateEndpoint '../private-endpoint/private-endpoint.bicep' = if (!empty(appConfigurationPrivateEndpoint)) {
  name: !empty(appConfigurationPrivateEndpoint)
    ? toLower('appc-private-ep-${guid('${appConfig.id}/${appConfigurationPrivateEndpoint.privateEndpointName}')}')
    : 'no-app-cfg-pri-endp-to-deploy'
  scope: resourceGroup()
  params: {
    region: region
    environment: environment
    privateEndpointName: appConfigurationPrivateEndpoint.privateEndpointName
    privateEndpointLocation: contains(appConfigurationPrivateEndpoint, 'privateEndpointLocation')
      ? appConfigurationPrivateEndpoint.privateEndpointLocation
      : appConfigurationLocation
    privateEndpointDnsZoneGroups: [
      for zone in appConfigurationPrivateEndpoint.privateEndpointDnsZoneGroupConfigs: {
        privateDnsZoneName: zone.privateDnsZone
        privateDnsZoneGroup: replace(zone.privateDnsZone, '.', '-')
        privateDnsZoneResourceGroup: zone.privateDnsZoneResourceGroup
      }
    ]
    privateEndpointVirtualNetworkName: appConfigurationPrivateEndpoint.privateEndpointVirtualNetworkName
    privateEndpointVirtualNetworkSubnetName: appConfigurationPrivateEndpoint.privateEndpointVirtualNetworkSubnetName
    privateEndpointVirtualNetworkResourceGroup: appConfigurationPrivateEndpoint.privateEndpointVirtualNetworkResourceGroup
    privateEndpointResourceIdLink: appConfig.id
    privateEndpointTags: contains(appConfigurationPrivateEndpoint, 'privateEndpointTags')
      ? appConfigurationPrivateEndpoint.privateEndpointTags
      : {}
    privateEndpointGroupIds: [
      'configurationStores'
    ]
  }
}

// 3. Return Deployment ouput
output appConfiguration object = appConfig
