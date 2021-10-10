/*
  NOTICE: This module is a generic parent to all role assignments modules
*/

@allowed([
  'dev'
  'qa'
  'uat'
  'prd'
])
@description('The environment in which the resource(s) will be deployed as part of the resource naming convention')
param environment string = 'dev'

@description('The location prefix for the resource name')
param location string = ''

@description('The role id to assign to the resource')
param resourceRoleName string

@allowed([
  'Resource'
  'ResourceGroup'
])
@description('')
param resourceRoleAssignmentScope string

@description('The resource type type to assign the role to')
param resourceTypeAssigningRole string

@description('The principal Id reciving the role assignment')
param resourcePrincipalIdRecievingRole string

@description('If scoping resource role assignment to a specific the resource the name of the resource must be specified')
param resourceToScopeRoleAssignment string = ''

@description('The name of the resource to scope role assignment to')
param resourceGroupToScopeRoleAssignment string

var ResourceGroup = resourceGroup(replace(replace(resourceGroupToScopeRoleAssignment, '@environment', environment), '@location', location))
var RoleDefinitionId = {
  AcrPush: '8311e382-0749-4cb8-b61a-304f252e45ec'
  APIManagementServiceContributor: '312a565d-c81f-4fd8-895a-4e21e48d571c'
  AcrPull: '7f951dda-4ed3-4680-a7ca-43fe172d538d'
  AcrImageSigner: '6cef56e8-d556-48e5-a04f-b8e64114680f'
  AcrDelete: 'c2f4ef07-c644-48eb-af81-4b1b4947fb11'
  AcrQuarantineReader: 'cdda3590-29a3-44f6-95f2-9f980659eb04'
  AcrQuarantineWriter: 'c8d4ff99-41c3-41a8-9f60-21dfdad59608'
  APIManagementServiceOperatorRole: 'e022efe7-f5ba-4159-bbe4-b44f577e9b61'
  APIManagementServiceReaderRole: '71522526-b88f-4d52-b57f-d31fc3546d0d'
  ApplicationInsightsComponentContributor: 'ae349356-3a1b-4a5e-921d-050484c6347e'
  ApplicationInsightsSnapshotDebugger: '08954f03-6346-4c2e-81c0-ec3a5cfae23b'
  AttestationReader: 'fd1bd22b-8476-40bc-a0bc-69b95687b9f3'
  AutomationJobOperator: '4fe576fe-1146-4730-92eb-48519fa6bf9f'
  AutomationRunbookOperator: '5fb5aef8-1081-4b8e-bb16-9d5d0385bab5'
  AutomationOperator: 'd3881f73-407a-4167-8283-e981cbba0404'
  AvereContributor: '4f8fab4f-1852-4a58-a46a-8eaf358af14a'
  AvereOperator: 'c025889f-8102-4ebf-b32c-fc0c6f0c6bd9'
  AzureKubernetesServiceClusterAdminRole: '0ab0b1a8-8aac-4efd-b8c2-3ee1fb270be8'
  AzureKubernetesServiceClusterUserRole: '4abbcc35-e782-43d8-92c5-2d3f1bd2253f'
  AzureMapsDataReader: '423170ca-a8f6-4b0f-8487-9e4eb8f49bfa'
  AzureStackRegistrationOwner: '6f12a6df-dd06-4f3e-bcb1-ce8be600526a'
  BackupContributor: '5e467623-bb1f-42f4-a55d-6e525e11384b'
  BillingReader: 'fa23ad8b-c56e-40d8-ac0c-ce449e1d2c64'
  BackupOperator: '00c29273-979b-4161-815c-10b084fb9324'
  BackupReader: 'a795c7a0-d4a2-40c1-ae25-d81f01202912'
  BlockchainMemberNodeAccess: '31a002a1-acaf-453e-8a5b-297c9ca1ea24'
  BizTalkContributor: '5e3c6656-6cfa-4708-81fe-0de47ac73342'
  CDNEndpointContributor: '426e0c7f-0c7e-4658-b36f-ff54d6c29b45'
  CDNEndpointReader: '871e35f6-b5c1-49cc-a043-bde969a0f2cd'
  CDNProfileContributor: 'ec156ff8-a8d1-4d15-830c-5b80698ca432'
  CDNProfileReader: '8f96442b-4075-438f-813d-ad51ab4019af'

  ClearDBMySQLDBContributor: '9106cda0-8a86-4e81-b686-29a22c54effe'

  CognitiveServicesUser: 'a97b65f3-24c7-4388-baec-2e87135dc908'
  CognitiveServicesDataReader: 'b59867f0-fa02-499b-be73-45a86b5b3e1c'
  CognitiveServicesContributor: '25fbc0a9-bd7c-42a3-aa1a-3b75d497ee68'
  CosmosBackupOperator: 'db7b14f2-5adf-42da-9f96-f2ee17bab5cb'
  Contributor: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
  CosmosDBAccountReaderRole: 'fbdf93bf-df7d-467e-a4d2-9458aa1360c8'
  CostManagementContributor: '434105ed-43f6-45c7-a02f-909b2ba83430'
  CostManagementReader: '72fafb9e-0641-4937-9268-a91bfd8191a3'
  DataBoxContributor: 'add466c9-e687-43fc-8d98-dfcf8d720be5'
  DataBoxReader: '028f4ed7-e2a9-465e-a8f4-9c0ffdfdc027'
  DataFactoryContributor: '673868aa-7521-48a0-acc6-0f60742d39f5'
  DataPurger: '150f5e0c-0603-4f03-8c7f-cf70034c4e90'
  DataLakeAnalyticsDeveloper: '47b7735b-770e-4598-a7da-8b91488b4c88'
  DevTestLabsUser: '76283e04-6283-4c54-8f91-bcf1374a3c64'
  DocumentDBAccountContributor: '5bd9cd88-fe45-4216-938b-f97437e15450'
  DNSZoneContributor: 'befefa01-2a29-4197-83a8-272ff33ce314'

  GraphOwner: 'b60367af-1334-4454-b71e-769d9a4f83d9'
  HDInsightDomainServicesContributor: '8d8d5a11-05d3-4bda-a417-a08778121c7c'
  IntelligentSystemsAccountContributor: '03a6d094-3444-4b3d-88af-7477090a9e5e'

  KnowledgeConsumer: 'ee361c5d-f7b5-4119-b4b6-892157c8f64c'
  LabCreator: 'b97fb8bc-a8b2-4522-a38b-dd33c7e65ead'
  LogAnalyticsReader: '73c42c96-874c-492b-b04d-ab87d138a893'
  LogAnalyticsContributor: '92aaf0da-9dab-42b6-94a3-d43ce8d16293'
  LogicAppOperator: '515c2055-d9d4-4321-b1b9-bd0c9a0f79fe'
  LogicAppContributor: '87a39d53-fc1b-424a-814c-f7e04687dc9e'
  ManagedApplicationOperatorRole: 'c7393b34-138c-406f-901b-d8cf2b17e6ae'
  ManagedApplicationsReader: 'b9331d33-8a36-4f8c-b097-4f54124fdb44'
  ManagedIdentityOperator: 'f1a07417-d97a-45cb-824c-7a7467783830'
  ManagedIdentityContributor: 'e40ec5ca-96e0-45a2-b4ff-59039f2c2b59'
  ManagementGroupContributor: '5d58bcaf-24a5-4b20-bdb6-eed9f69fbe4c'
  ManagementGroupReader: 'ac63b705-f282-497d-ac71-919bf39d939d'
  MonitoringMetricsPublisher: '3913510d-42f4-4e42-8a64-420c390055eb'
  MonitoringReader: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
  NetworkContributor: '4d97b98b-1d4f-4787-a291-c67834d212e7'
  MonitoringContributor: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
  NewRelicAPMAccountContributor: '5d28c62d-5b37-4476-8438-e587778df237'
  Owner: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
  Reader: 'acdd72a7-3385-48ef-bd42-f606fba81ae7'
  RedisCacheContributor: 'e0f68234-74aa-48ed-b826-c38b57376e17'
  ReaderandDataAccess: 'c12c1c16-33a1-487b-954d-41c89c60f349'
  ResourcePolicyContributor: '36243c78-bf99-498c-9df9-86d9f8d28608'
  SchedulerJobCollectionsContributor: '188a0f2f-5c9e-469b-ae67-2aa5ce574b94'
  SearchServiceContributor: '7ca78c08-252a-4471-8644-bb5ff32d4ba0'
  SecurityAdmin: 'fb1c8493-542b-48eb-b624-b4c8fea62acd'
  SecurityManager: 'e3d13bf0-dd5a-482e-ba6b-9b8433878d10'
  SecurityReader: '39bc4728-0917-49c7-9d2c-d95423bc2eb4'
  SpatialAnchorsAccountContributor: '8bbe83f1-e2a6-4df7-8cb4-4e04d4e5c827'
  SiteRecoveryContributor: '6670b86e-a3f7-4917-ac9b-5d6ab1be4567'
  SiteRecoveryOperator: '494ae006-db33-4328-bf46-533a6560a3ca'
  SpatialAnchorsAccountReader: '5d51204f-eb77-4b1c-b86a-2ec626c49413'
  SiteRecoveryReader: 'dbaa88c4-0c30-4179-9fb3-46319faa6149'
  SpatialAnchorsAccountOwner: '70bbe301-9835-447d-afdd-19eb3167307c'
  SQLManagedInstanceContributor: '4939a1f6-9ae0-4e48-a1e0-f2cbe897382d'
  SQLDBContributor: '9b7fa17d-e63e-47b0-bb0a-15c516ac86ec'
  SQLSecurityManager: '056cd41c-7e88-42e1-933e-88ba6a50c9c3'

  SQLServerContributor: '6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437'

  SupportRequestContributor: 'cfd33db0-3dd1-45e3-aa9d-cdbdf3b6f24e'
  TrafficManagerContributor: 'a4b10055-b0c7-44c2-b00f-c7b5b3550cf7'
  VirtualMachineAdministratorLogin: '1c0163c0-47e6-4577-8991-ea5c82e286e4'
  UserAccessAdministrator: '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
  VirtualMachineUserLogin: 'fb879df8-f326-4884-b1cf-06f3ad86be52'
  VirtualMachineContributor: '9980e02c-c2be-4d73-94e8-173b1dc7cf3c'
  WebPlanContributor: '2cc479cb-7b4d-49a8-b449-8c00fd0f0a4b'
  WebsiteContributor: 'de139f84-1756-47ae-9be6-808fbbe84772'
  AzureServiceBusDataOwner: '090c5cfd-751d-490a-894a-3ce6f1109419'
  AzureEventHubsDataOwner: 'f526a384-b230-433a-b45c-95f59c4a2dec'
  AttestationContributor: 'bbf86eb8-f7b4-4cce-96e4-18cddf81d86e'
  HDInsightClusterOperator: '61ed4efc-fab3-44fd-b111-e24485cc132a'
  CosmosDBOperator: '230815da-be43-4aae-9cb4-875f7bd000aa'
  HybridServerResourceAdministrator: '48b40c6e-82e0-4eb3-90d5-19e40f49b624'
  HybridServerOnboarding: '5d1e5ee4-7c68-4a71-ac8b-0739630a3dfb'
  AzureEventHubsDataReceiver: 'a638d3c7-ab3a-418d-83e6-5f17a39d4fde'
  AzureEventHubsDataSender: '2b629674-e913-4c01-ae53-ef4638d8f975'
  AzureServiceBusDataReceiver: '4f6d3b9b-027b-4f4c-9142-0e5a2a2247e0'
  AzureServiceBusDataSender: '69a216fc-b8fb-44d8-bc22-1f3c2cd27a39'

  PrivateDNSZoneContributor: 'b12aa53e-6015-4669-85d0-8515ebb3ae7f'

  DesktopVirtualizationUser: '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63'

  BlueprintContributor: '41077137-e803-4205-871c-5a86e6a753b4'
  BlueprintOperator: '437d2ced-4a38-4302-8479-ed2bcb43d090'
  AzureSentinelContributor: 'ab8e14d6-4a74-4a29-9ba8-549422addade'
  AzureSentinelResponder: '3e150937-b8fe-4cfb-8069-0eaf05ecd056'
  AzureSentinelReader: '8d289c81-5878-46d4-8554-54e1e3d8b5cb'
  WorkbookReader: 'b279062a-9be3-42a0-92ae-8b3cf002ec4d'
  WorkbookContributor: 'e8ddcd69-c73f-4f9f-9844-4100522f16ad'
  PolicyInsightsDataWriter: '66bb4e9e-b016-4a94-8249-4c0511c2be84'
  SignalRAccessKeyReader: '04165923-9d83-45d5-8227-78b77b0a687e'
  SignalRContributor: '8cf5e20a-e4b2-4e9d-b3a1-5ceb692c2761'
  AzureConnectedMachineOnboarding: 'b64e21ea-ac4e-4cdf-9dc9-5b892992bee7'
  AzureConnectedMachineResourceAdministrator: 'cd570a14-e51a-42ad-bac8-bafd67325302'
  ManagedServicesRegistrationassignmentDeleteRole: '91c1777a-f3dc-4fae-b103-61d183457e46'

  KubernetesClusterAzureArcOnboarding: '34e09817-6cbe-4d01-b1a2-e0eac5743d41'
  ExperimentationContributor: '7f646f1b-fa08-80eb-a22b-edd6ce5c915c'
  CognitiveServicesQnAMakerReader: '466ccd10-b268-4a11-b098-b4849f024126'
  CognitiveServicesQnAMakerEditor: 'f4cc2bf9-21be-47a1-bdf1-5c5804381025'
  ExperimentationAdministrator: '7f646f1b-fa08-80eb-a33b-edd6ce5c915c'
  RemoteRenderingAdministrator: '3df8b902-2a6f-47c7-8cc5-360e9b272a7e'
  RemoteRenderingClient: 'd39065c4-c120-43c9-ab0a-63eed9795f0a'
  ManagedApplicationContributorRole: '641177b8-a67a-45b9-a033-47bc880bb21e'
  SecurityAssessmentContributor: '612c2aa1-cb24-443b-ac28-3ab7272de6f5'
  TagContributor: '4a9ae827-6dc8-4573-8ac7-8239d42aa03f'
  IntegrationServiceEnvironmentDeveloper: 'c7aa55d3-1abb-444a-a5ca-5e51e485d6ec'
  IntegrationServiceEnvironmentContributor: 'a41e2c5b-bd99-4a07-88f4-9bf657a760b8'
  AzureKubernetesServiceContributorRole: 'ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8'
  AzureDigitalTwinsDataReader: 'd57506d4-4c8d-48b1-8587-93c323f6a5a3'
  AzureDigitalTwinsDataOwner: 'bcd981a7-7f74-457b-83e1-cceb9e632ffe'
  HierarchySettingsAdministrator: '350f8d15-c687-4448-8ae1-157740a3936d'
  FHIRDataContributor: '5a1fc7df-4bf1-4951-a576-89034ee01acd'
  FHIRDataExporter: '3db33094-8700-4567-8da5-1501d4e7e843'
  FHIRDataReader: '4c8d0bbc-75d3-4935-991f-5f3c56d81508'
  FHIRDataWriter: '3f88fce4-5892-4214-ae73-ba5294559913'
  ExperimentationReader: '49632ef5-d9ac-41f4-b8e7-bbe587fa74a1'
  ObjectUnderstandingAccountOwner: '4dd61c23-6743-42fe-a388-d8bdd41cb745'
  AzureMapsDataContributor: '8f5e0ce6-4f7b-4dcf-bddf-e6f48634a204'
  CognitiveServicesCustomVisionContributor: 'c1ff6cc2-c111-46fe-8896-e0ef812ad9f3'
  CognitiveServicesCustomVisionDeployment: '5c4089e1-6d96-4d2f-b296-c1bc7137275f'
  CognitiveServicesCustomVisionLabeler: '88424f51-ebe7-446f-bc41-7fa16989e96c'
  CognitiveServicesCustomVisionReader: '93586559-c37d-4a6b-ba08-b9f0940c2d73'
  CognitiveServicesCustomVisionTrainer: '0a5ae4ab-0d65-4eeb-be61-29fc9b54394b'

  AzureArcKubernetesViewer: '63f0a09d-1495-4db4-a681-037d84835eb4'
  AzureArcKubernetesWriter: '5b999177-9696-4545-85c7-50de3797e5a1'
  AzureArcKubernetesClusterAdmin: '8393591c-06b9-48a2-a542-1bd6b377f6a2'
  AzureArcKubernetesAdmin: 'dffb1e0c-446f-4dde-a09f-99eb5cc68b96'
  AzureKubernetesServiceRBACClusterAdmin: 'b1ff04bb-8a4e-4dc4-8eb5-8693973ce19b'
  AzureKubernetesServiceRBACAdmin: '3498e952-d568-435e-9b2c-8d77e338d7f7'
  AzureKubernetesServiceRBACReader: '7f6c6a51-bcf8-42ba-9220-52d62157d7db'
  AzureKubernetesServiceRBACWriter: 'a7ffa36f-339b-4b5c-8bdf-e2c188b2c0eb'
  ServicesHubOperator: '82200a5b-e217-47a5-b665-6d8765ee745b'
  ObjectUnderstandingAccountReader: 'd18777c0-1514-4662-8490-608db7d334b6'
  AzureArcEnabledKubernetesClusterUserRole: '00493d72-78f6-4148-b6c5-d3ce8e4799dd'
  SignalRAppServer: '420fcaa2-552c-430f-98ca-3264be4806c7'
  SignalRServerlessContributor: 'fd53cd77-2268-407a-8f46-7e7863d0f521'
  CollaborativeDataContributor: 'daa9e50b-21df-454c-94a6-a8050adab352'
  DeviceUpdateReader: 'e9dba6fb-3d52-4cf0-bce3-f06ce71b9e0f'
  DeviceUpdateAdministrator: '02ca0879-e8e4-47a5-a61e-5c618b76e64a'
  DeviceUpdateContentAdministrator: '0378884a-3af5-44ab-8323-f5b22f9f3c98'
  DeviceUpdateDeploymentsAdministrator: 'e4237640-0e3d-4a46-8fda-70bc94856432'
  DeviceUpdateDeploymentsReader: '49e2f5d2-7741-4835-8efa-19e1fe35e47f'
  DeviceUpdateContentReader: 'd1ee9a80-8b14-47f0-bdc2-f4a351625a7b'
  CognitiveServicesMetricsAdvisorAdministrator: 'cb43c632-a144-4ec5-977c-e80c4affc34a'
  CognitiveServicesMetricsAdvisorUser: '3b20f47b-3825-43cb-8114-4bd2201156a8'
  SchemaRegistryReader: '2c56ea50-c6b3-40a6-83c0-9d98858bc7d2'
  SchemaRegistryContributor: '5dffeca3-4936-4216-b2bc-10343a5abb25'
  AgFoodPlatformServiceReader: '7ec7ccdc-f61e-41fe-9aaf-980df0a44eba'
  AgFoodPlatformServiceContributor: '8508508a-4469-4e45-963b-2518ee0bb728'
  AgFoodPlatformServiceAdmin: 'f8da80de-1ff9-4747-ad80-a19b7f6079e3'
  ManagedHSMcontributor: '18500a29-7fe2-46b2-a342-b16a415e101d'
  SecurityDetonationChamberSubmitter: '0b555d9b-b4a7-4f43-b330-627f0e5be8f0'
  SignalRServiceReader: 'ddde6b66-c0df-4114-a159-3618637b3035'
  SignalRServiceOwner: '7e4f1700-ea5a-4f59-8f37-079cfe29dce3'
  ReservationPurchaser: 'f7b75c60-3036-4b75-91c3-6b41c27c1689'
  AzureMLMetricsWriter: '635dd51f-9968-44d3-b7fb-6d9a6bd613ae'

  ExperimentationMetricContributor: '6188b7c9-7d01-4f99-a59f-c88b630326c0'
  ProjectBabylonDataCurator: '9ef4ef9c-a049-46b0-82ab-dd8ac094c889'
  ProjectBabylonDataReader: 'c8d896ba-346d-4f50-bc1d-7d1c84130446'
  ProjectBabylonDataSourceAdministrator: '05b7651b-dc44-475e-b74d-df3db49fae0f'
  PurviewDataCurator: '8a3c2885-9b38-4fd2-9d99-91af537c1347'
  PurviewDataReader: 'ff100721-1b9d-43d8-af52-42b69c1272db'
  PurviewDataSourceAdministrator: '200bba9e-f0c8-430f-892b-6f0794863803'
  ApplicationGroupContributor: 'ca6382a4-1721-4bcf-a114-ff0c70227b6b'
  DesktopVirtualizationReader: '49a72310-ab8d-41df-bbb0-79b649203868'
  DesktopVirtualizationContributor: '082f0a83-3be5-4ba1-904c-961cca79b387'
  DesktopVirtualizationWorkspaceContributor: '21efdde3-836f-432b-bf3d-3e8e734d4b2b'
  DesktopVirtualizationUserSessionOperator: 'ea4bfff8-7fb4-485a-aadd-d4129a0ffaa6'
  DesktopVirtualizationSessionHostOperator: '2ad6aaab-ead9-4eaa-8ac5-da422f562408'
  DesktopVirtualizationHostPoolReader: 'ceadfde2-b300-400a-ab7b-6143895aa822'
  DesktopVirtualizationHostPoolContributor: 'e307426c-f9b6-4e81-87de-d99efb3c32bc'
  DesktopVirtualizationApplicationGroupReader: 'aebf23d0-b568-4e86-b8f9-fe83a2c6ab55'
  DesktopVirtualizationApplicationGroupContributor: '86240b0e-9422-4c43-887b-b61143f32ba8'
  DesktopVirtualizationWorkspaceReader: '0fa44ee9-7a7d-466b-9bb2-2bf446b1204d'
  DiskBackupReader: '3e5e47e6-65f7-47ef-90b5-e5dd4d455f24'
  AutonomousDevelopmentPlatformDataContributor: 'b8b15564-4fa6-4a59-ab12-03e1d9594795'
  AutonomousDevelopmentPlatformDataReader: 'd63b75f7-47ea-4f27-92ac-e0d173aaf093'
  AutonomousDevelopmentPlatformDataOwner: '27f8b550-c507-4db9-86f2-f4b8e816d59d'
  DiskRestoreOperator: 'b50d9833-a0cb-478e-945f-707fcc997c13'
  DiskSnapshotContributor: '7efff54f-a5b4-42b5-a1c5-5411624893ce'
  MicrosoftKubernetesconnectedclusterrole: '5548b2cf-c94c-4228-90ba-30851930a12f'
  SecurityDetonationChamberSubmissionManager: 'a37b566d-3efa-4beb-a2f2-698963fa42ce'
  SecurityDetonationChamberPublisher: '352470b3-6a9c-4686-b503-35deb827e500'
  CollaborativeRuntimeOperator: '7a6f0e70-c033-4fb1-828c-08514e5f4102'
  CosmosRestoreOperator: '5432c526-bc82-444a-b7ba-57c5b0b5b34f'
  FHIRDataConverter: 'a1705bd2-3a8f-45a5-8683-466fcfd5cc24'
  AzureSentinelAutomationContributor: 'f4c81013-99ee-4d62-a7ee-b3f1f648599a'
  QuotaRequestOperator: '0e5f05e5-9ab9-446b-b98d-1e2157c94125'

  SecurityDetonationChamberReader: '28241645-39f8-410b-ad48-87863e2951d5'
  ObjectAnchorsAccountReader: '4a167cdf-cb95-4554-9203-2347fe489bd9'
  ObjectAnchorsAccountOwner: 'ca0835dd-bacc-42dd-8ed2-ed5e7230d15b'
  WorkloadBuilderMigrationAgentRole: 'd17ce0a2-0697-43bc-aac5-9113337ab61c'
  WebPubSubServiceOwner: '12cf5a90-567b-43ae-8102-96cf46c7d9b4'
  WebPubSubServiceReader: 'bfb1c7d2-fb1a-466b-b2ba-aee63b92deaf'
  AzureSpringCloudDataReader: 'b5537268-8956-4941-a8f0-646150406f0c'
  CognitiveServicesSpeechUser: 'f2dc8367-1007-4938-bd23-fe263f013447'
  CognitiveServicesSpeechContributor: '0e75ca1e-0464-4b4d-8b93-68208a576181'
  CognitiveServicesFaceRecognizer: '9894cab4-e18a-44aa-828b-cb588cd6f2d7'
  MediaServicesAccountAdministrator: '054126f8-9a2b-4f1c-a9ad-eca461f08466'
  MediaServicesLiveEventsAdministrator: '532bc159-b25e-42c0-969e-a1d439f60d77'
  MediaServicesMediaOperator: 'e4395492-1534-4db2-bedf-88c14621589c'
  MediaServicesPolicyAdministrator: 'c4bba371-dacd-4a26-b320-7250bca963ae'
  MediaServicesStreamingEndpointsAdministrator: '99dba123-b5fe-44d5-874c-ced7199a5804'
  StreamAnalyticsQueryTester: '1ec5b3c1-b17e-4e25-8312-2acb3c3c5abf'
  AnyBuildBuilder: 'a2138dac-4907-4679-a376-736901ed8ad8'
  IoTHubDataReader: 'b447c946-2db7-41ec-983d-d8bf3b1c77e3'
  IoTHubTwinContributor: '494bdba2-168f-4f31-a0a1-191d2f7c028c'
  IoTHubRegistryContributor: '4ea46cd5-c1b2-4a8e-910b-273211f9ce47'
  IoTHubDataContributor: '4fc6c259-987e-4a07-842e-c321cc9d413f'
  TestBaseReader: '15e0f5a1-3450-4248-8e25-e2afe88a9e85'
  SearchIndexDataReader: '1407120a-92aa-4202-b7e9-c0e197c71c8f'
  SearchIndexDataContributor: '8ebe5a00-799e-43f5-93ac-243d3dce84a7'

  DICOMDataReader: 'e89c7a3c-2f64-4fa1-a847-3e4c9ba4283a'
  DICOMDataOwner: '58a3b984-7adf-4c20-983a-32417c86fbc8'

  AzureMLDataScientist: 'f6c7c914-8db3-469d-8ca1-694a8f32e121'
}

// 1. Check for Azure App Configuration Role Assignment
module azAppConfigurationRoleAssignment 'az.sec.role.assignment.app.configuration.bicep' = if (resourceTypeAssigningRole == 'Microsoft.AppConfiguration/ConfigurationStores') {
  name: 'az-appc-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}

// 2. Check for Azure Key Vault Role Assignments
module azKeyVaultRoleAssignment 'az.sec.role.assignment.key.vault.bicep' = if (resourceTypeAssigningRole == 'Microsoft.KeyVault/Vaults') {
  name: 'az-kv-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}

// 3. Check for Azure Event Grid Role Assignment
module azEventGridRoleAssignment 'az.sec.role.assignment.event.grid.bicep' = if (resourceTypeAssigningRole == 'Microsoft.EventGrid/Domains') {
  name: 'az-kv-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}

// 4. Check for Azure Storage Account Role Assignment
module azStorageAccountRoleAssignment 'az.sec.role.assignment.storage.bicep' = if (resourceTypeAssigningRole == 'Microsoft.Storage/StorageAccounts') {
  name: 'az-stg-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}

// 5. Check for Azure Storage Account Blob Services Role Assignment
module azStorageAccountBlobContainerRoleAssignment 'az.sec.role.assignment.storage.blob.bicep' = if (resourceTypeAssigningRole == 'Microsoft.Storage/StorageAccounts/BlobServices/Containers') {
  name: 'az-stg-blob-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}


// 6. Check for Azure Storage Account File Share Services Role Assignment
module azStorageFileShareAccountRoleAssignment 'az.sec.role.assignment.storage.fileshare.bicep' = if (resourceTypeAssigningRole == 'Microsoft.Storage/StorageAccounts/FileServices/Shares') {
  name: 'az-stg-fs-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}


// 7. Check for Azure EStorage Account Queue Services Role Assignment
module azStorageAccountQueueRoleAssignment 'az.sec.role.assignment.storage.queue.bicep' = if (resourceTypeAssigningRole == '"Microsoft.Storage/StorageAccounts/QueueServices/Queues') {
  name: 'az-stg-queue-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}

// 3. Check for Azure Storage Account Tables Services Role Assignment
module azStorageAccountTableRoleAssignment 'az.sec.role.assignment.storage.table.bicep' = if (resourceTypeAssigningRole == 'Microsoft.Storage/StorageAccounts/TableServices/Table') {
  name: 'az-stg-table-role-assign-${guid('${resourceRoleName}-${resourcePrincipalIdRecievingRole}')}'
  scope: ResourceGroup
  params: {
    environment: environment
    location: location
    resourceRoleName: resourceRoleName
    resourceRoleAssignmentScope: resourceRoleAssignmentScope
    resourceToScopeRoleAssignment: resourceToScopeRoleAssignment
    resourcePrincipalIdRecievingRole: resourcePrincipalIdRecievingRole
  }
}
