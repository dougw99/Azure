# Bicep scripts for Azure
This is a solution for common resources to be deployed to Azure.  This is a collection of bicep script to use.

## Syntax
- Update the main.bicep script
- Create a resource group for your service or use an existing resource group
- Run the commands below

Login to azure via the command line. If you are using cloudshell this is not needed.
```
az login
```
Run the az deployment command with group command to setup the resource within the group.  This is assuming the group already exists and you have at least contributor permissions to perform the work.  Owner might be required in some cases.
```
az deployment group create --what-if --resource-group GROUP --template-file main.bicep
```