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

// deploy the modules as needed by setting the value to true
param deploy_storage bool = false
param deploy_kv bool = false

module stgModule 'module/storage.bicep' = if (deploy_storage) {
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

module kvModule 'module/keyvault.bicep' = if (deploy_kv) {
  name: 'keyvaultDeploy'
  scope: resourceGroup()
  params: {
    keyVaultName: kvName
    tags: tags
    location: location
  }

}


