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

@description('The name of the service bus to deploy')
param serviceBusName string

@description('The location/region the Azure Service Bus Instance will be deployed to.')
param serviceBusLocation string = resourceGroup().location

@description('A collection of service bus topics to be deployed with the namespace.')
param serviceBusTopics array = []

@description('A collection of service bus queues to be deployed with the namespace.')
param serviceBusQueues array = []

@description('The pricing tier to be used for the service bus.')
param serviceBusSku object 

@description('')
param serviceBusEnableMsi bool = false

@description('')
param serviceBusPolicies array = []

@description('')
param serviceBusPrivateEndpoint object = {}

@description('')
param serviceBusTags object = {}

// 1. Deploy Service Bus Namespace
resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: replace(replace(serviceBusName, '@environment', environment), '@region', region)
  location: serviceBusLocation
  identity: any(serviceBusEnableMsi ? {
    type: 'SystemAssigned'
  } : null)
  sku: any(contains(serviceBusSku, environment) ? {
    name: serviceBusSku[environment]
    tier: serviceBusSku[environment]
  } : {
    name: serviceBusSku.default
    tier: serviceBusSku.default
  })
  tags: union(serviceBusTags, {
      region: empty(region) ? 'n/a' : region
      environment: empty(environment) ? 'n/a' : environment
    })

  // Neet to use a different API version version than parent since preview supports managed identity while auth rules are supported up to 2017-04-01
  resource serviceBusNamespaceAuthorizationRules 'AuthorizationRules' = [for policy in serviceBusPolicies: if (!empty(policy)) {
    name: !empty(serviceBusPolicies) ? policy.serviceBusPolicyName : 'no-sb-policies-to-deploy'
    properties: {
      rights: policy.serviceBusPolicyPermissions
    }
  }]
}

// 2. Deploy Servic Bus Queues if applicable
module serviceBusNamespaceQueue 'service-bus-namespace-queue.bicep' = [for queue in serviceBusQueues: if (!empty(queue)) {
  name: !empty(serviceBusQueues) ? toLower('sbn-queue-${guid('${serviceBusNamespace.id}/${queue.serviceBusQueueName}')}') : 'no-sb-queues-to-deploy'
  scope: resourceGroup()
  params: {
    region: region
    environment: environment
    serviceBusName: serviceBusName
    serviceBusQueueName: queue.serviceBusQueueName
    serviceBusQueuePolicies: queue.?serviceBusQueuePolicies
    serviceBusQueueSettings: queue.?serviceBusQueueSettings
  }
}]

// 3. Deploy Servic Bus Topics & Subscriptions if applicable
module serviceBusNamespaceTopic 'service-bus-namespace-topic.bicep' = [for topic in serviceBusTopics: if (!empty(topic)) {
  name: !empty(serviceBusTopics) ? toLower('sbn-topic-${guid('${serviceBusNamespace.id}/${topic.serviceBusTopicName}')}') : 'no-sb-topic-to-deploy'
  scope: resourceGroup()
  params: {
    region: region
    environment: environment
    serviceBusName: serviceBusName
    serviceBusTopicName: topic.serviceBusTopicName
    serviceBusTopicSubscriptions: topic.?serviceBusTopicSubscriptions
    serviceBusTopicPolicies: topic.?serviceBusTopicPolicies
    serviceBusTopicSettings: topic.?serviceBusTopicSettings
  }
}]

module privateEndpoint '../private-endpoint/private-endpoint.bicep' = if (!empty(serviceBusPrivateEndpoint)) {
  name: !empty(serviceBusPrivateEndpoint) ? toLower('cdb-private-ep-${guid('${serviceBusNamespace.id}/${serviceBusPrivateEndpoint.privateEndpointName}')}') : 'no-cosmosdb-priv-endp-to-deploy'
  params: {
    region: region
    environment: environment
    privateEndpointName: serviceBusPrivateEndpoint.privateEndpointName
    privateEndpointLocation: contains(serviceBusPrivateEndpoint, 'privateEndpointLocation') ? serviceBusPrivateEndpoint.privateEndpointLocation : serviceBusLocation
    privateEndpointDnsZoneGroups: [
      for zone in serviceBusPrivateEndpoint.privateEndpointDnsZoneGroupConfigs: {
        privateDnsZoneName: zone.privateDnsZone
        privateDnsZoneGroup: replace(zone.privateDnsZone, '.', '-')
        privateDnsZoneResourceGroup: zone.privateDnsZoneResourceGroup
      }
    ]
    privateEndpointVirtualNetworkName: serviceBusPrivateEndpoint.privateEndpointVirtualNetworkName
    privateEndpointVirtualNetworkSubnetName: serviceBusPrivateEndpoint.privateEndpointVirtualNetworkSubnetName
    privateEndpointVirtualNetworkResourceGroup: serviceBusPrivateEndpoint.privateEndpointVirtualNetworkResourceGroup
    privateEndpointResourceIdLink: serviceBusNamespace.id
    privateEndpointTags: contains(serviceBusPrivateEndpoint, 'privateEndpointTags') ? serviceBusPrivateEndpoint.privateEndpointTags : {}
    privateEndpointGroupIds: [
      'namespace'
    ]
  }
}

output serviceBusNamespace object = serviceBusNamespace
