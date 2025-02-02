// Naming standards adopted from azure caf
targetScope = 'subscription'

@maxLength(8)
param applicationName string

@allowed([
  'dev'
  'tst'
  'qas'
  'prd'
])
param environment string

@maxLength(3)
param regionCode string // 3 letter code i.e. weu, esu

var environmentLetter = substring(environment,0,1)

output vnet string = 'vnet-${applicationName}-${environmentLetter}-${regionCode}'
output resourceGroup string = 'rg-${applicationName}-${environmentLetter}-${regionCode}'
output storageAccount string = 'st${applicationName}${environmentLetter}${regionCode}'
output keyVault string = 'kv-${applicationName}-${environmentLetter}-${regionCode}'
output appService string = 'app-${applicationName}-${environmentLetter}-${regionCode}'
output funcApp string = 'func-${applicationName}-${environmentLetter}-${regionCode}'
output workBook string = 'wkb-${applicationName}-${environmentLetter}-${regionCode}'
