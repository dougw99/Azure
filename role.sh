#!/bin/bash
# Assign Reader roles to managed identity for a Storage Account

handle_error() {
 echo "An error occurred. Exiting..."
 exit 1
}

trap handle_error ERR

# Get input from the user
read -p "Enter the Managed Identity Name: " miName
read -p "Enter the Managed Identity RG: " miGroup
read -p "Enter the Storage Account Name: " stName
read -p "Enter the Storage Account RG: " stGroup

spID=$(az identity show -g $miGroup -n $miName --query principalId -o tsv)
stID=$(az storage account show -g $stGroup -n $stName --query id -o tsv)

echo "Managed Identity Name=$miName and Group=$miGroup"
echo "Storage Account Name=$stName and Group=$stGroup"

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

az role assignment create --assignee-object-id $spID --assignee-principal-type ServicePrincipal --role 'Reader' --scope $stID