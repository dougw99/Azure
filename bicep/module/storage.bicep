// Parameters for the storage module

@description('Enter in the prefix 3 to 7 characters')
@minLength(3)
@maxLength(7)
param prefix string

@description('Enter in the application name')
param appName string

@description('Enter in the environment dev,test, or prod')
param env string

@description('Optional: tags to attach to the storage account')
param tags object = {}

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'

@description('Enter in the location of the storage account')
param location string

// Create storage account name from the parameters
var uniqueStorageName = '${prefix}${appName}${env}'
resource stg 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
  tags: tags
}

output storageEndpoint object = stg.properties.primaryEndpoints
