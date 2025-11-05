@description('Name of the Key Vault (must be globally unique)')
param keyVaultName string

@description('Location for the Key Vault')
param location string = resourceGroup().location

@description('Optional: subnet ID to restrict traffic (private‑endpoint scenario)')
param networkSubnetId string = ''

@description('Optional: enable soft‑delete (default true)')
param enableSoftDelete bool = true

@description('Optional: enable purge protection (recommended when soft‑delete is on)')
param enablePurgeProtection bool = true

@description('Optional: tags to attach to the Key Vault')
param tags object = {}

resource keyVault 'Microsoft.KeyVault/vaults@2024-11-01' = {
  name: keyVaultName
  location: location
  properties: {
    // RBAC‑only mode – disable legacy access policies
    enableRbacAuthorization: true

    // Optional legacy flags (kept for compatibility)
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: false

    enableSoftDelete: enableSoftDelete
    softDeleteRetentionInDays: 90
    enablePurgeProtection: true

    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: networkSubnetId == '' ? 'Allow' : 'Deny'
      ipRules: []
      
      virtualNetworkRules: networkSubnetId == '' ? [] : [
        {
          id: networkSubnetId
        }
      ]
    }

    // No legacy accessPolicies – all permissions are RBAC‑based
  }
  tags: tags
}

output keyVaultUri string = keyVault.properties.vaultUri
