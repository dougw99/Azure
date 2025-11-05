@description('Enter in the location of the storage account')
param location string

@description('Name of the managed identity')
param umiName string

@description('Tags for the user managed identity')
param tags object = {}

resource mgIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2024-11-30' = {
  name: umiName
  location: location
  tags: tags
}
