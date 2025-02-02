targetScope = 'resourceGroup'

// Parameters
param storageAccountName string
param location string

// Resources
resource myStorageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

// Output 
//
output resourceId string = myStorageAccount.id
