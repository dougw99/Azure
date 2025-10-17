@minLength(3)
@maxLength(7)
param prefix string = 'eastus'

param appName string = 'testapp'
param env string = 'dev'
param location string = 'eastus'
param kvName string = 'testkv'

param tags object ={
  environment: env
  projectName: appName
}


module stgModule 'module/storage.bicep' = {
  name: 'storageDeploy'
  scope: resourceGroup()
  params: {
    prefix: prefix
    location: location
    storageSKU: 'Standard_LRS'
    env: env
    appName: appName
    tags: tags
  }
}

module kvModule 'module/keyvault.bicep' = {
  name: 'keyvaultDeploy'
  scope: resourceGroup()
  params: {
    keyVaultName: kvName
    tags: tags
    location: location
  }

}

output storageEndpoint object = stgModule.outputs.storageEndpoint
