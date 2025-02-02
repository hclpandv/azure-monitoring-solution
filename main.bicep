// Parameters
//
targetScope = 'subscription'

param applicationName string = 'vikimon'
param environment string = 'dev'
param regionCode string = 'weu'

// Variables
//
var regionMapping = {
  weu: 'westeurope'
  neu: 'northeurope'
}
var rgPrefix = 'rg-${applicationName}-${substring(environment,0,1)}-${regionCode}'
var workbookJson_01 = string(loadJsonContent('workbooks/optimization.json'))
var workbookJson_02 = string(loadJsonContent('workbooks/orphaned_resources.json'))

// Resource Groups
resource rg_01 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${rgPrefix}-01'
  location: regionMapping[regionCode]
}

// Resources
//
module namingPrefixes 'modules/namingPrefixes.bicep' = {
  name: '${deployment().name}-namingPrefixes'
  params: {
    applicationName: applicationName
    environment: environment
    regionCode: regionCode
  }
}

module workbook_01 'modules/workbook.bicep' = {
  scope: rg_01
  name: '${deployment().name}-workbookDeploy-01'
  params: {
    displayName: 'vikiscripts: Optimization Workbook'
    description: 'Reports to help you optimize your cost.'
    workbookJson: workbookJson_01
  }
}

module workbook_02 'modules/workbook.bicep' = {
  scope: rg_01
  name: '${deployment().name}-workbookDeploy-02'
  params: {
    displayName: 'vikiscripts: Orphaned Resources'
    description: 'Reports to help you identify the orphaned resourecs.'
    workbookJson: workbookJson_02
  }
}

// Outputs
//

