//
// Update the parameters here or use a parameter file with the deployment command to set the parameters
// Enable the resources to deploy by setting the deploy_ parameter to true
// 

// these are all the parameters for deploying the resources
@minLength(3)
@maxLength(7)
param prefix string = 'eastus'
param env string = 'dev'
param location string = 'eastus'
param appName string = 'testapp'
param kvName string = 'testkv'
param umiName string = 'testumi'
param storSKU string = 'Standard_LRS'

// Tag settings, use what you want here <key>: <value>
param tags object ={
  environment: env
  projectName: appName
}

// deploy the modules as needed by setting the value to true
param deploy_storage bool = false
param deploy_kv bool = false
param deploy_umi bool = true

// Storage account module
module stgModule 'module/storage.bicep' = if (deploy_storage) {
  name: 'storageDeploy'
  scope: resourceGroup()
  params: {
    prefix: prefix
    location: location
    storageSKU: storSKU
    env: env
    appName: appName
    tags: tags
  }
}

// Keyvault module
module kvModule 'module/keyvault.bicep' = if (deploy_kv) {
  name: 'keyvaultDeploy'
  scope: resourceGroup()
  params: {
    keyVaultName: kvName
    tags: tags
    location: location
  }

}

// Managed Identity Module
module mgModule 'module/umi.bicep' = if (deploy_umi) {
  name: 'umiDeploy'
  scope: resourceGroup()
  params: {
    location: location
    umiName: umiName
    tags: tags
  }
}
