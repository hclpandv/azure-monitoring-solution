targetScope = 'resourceGroup'

// Parameters
//
@sys.description('Display name for the workbook. Must be unique in the resource group.')
param displayName string

@sys.description('Optional. Location of the resources. Default: Same as deployment.')
param location string = resourceGroup().location

@sys.description('Optional. Workbook description.')
param description string

@sys.description('Workbook json serialized.')
param workbookJson string 

@sys.description('Optional. Tags for all resources.')
param tags object = {}


// Variables
//
var version = '1.0'


// Resources
//
resource workbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: guid(resourceGroup().id, 'Microsoft.Insights/workbooks', displayName)
  location: location
  tags: tags
  kind: 'shared'
  properties: {
    category: 'workbook'
    description: description
    displayName: displayName
    serializedData: workbookJson
    sourceId: 'Azure Monitor'
    version: version
  }
}

// Outputs
//
@sys.description('The resource ID of the workbook.')
output workbookId string = workbook.id

@sys.description('Link to the workbook in the Azure portal.')
output workbookUrl string = '${environment().portal}/#view/AppInsightsExtension/UsageNotebookBlade/ComponentId/Azure%20Monitor/ConfigurationId/${uriComponent(workbook.id)}/Type/${workbook.properties.category}/WorkbookTemplateName/${uriComponent(workbook.properties.displayName)}'
