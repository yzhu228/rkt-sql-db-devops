param sqlServerName string
param sqlDbName string
param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2021-11-01-preview' existing = {
  name: sqlServerName
}

resource sqlDb 'Microsoft.Sql/servers/databases@2021-11-01-preview' = {
  name: sqlDbName
  parent: sqlServer
  location: location
  sku: {
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  properties: {
    maxSizeBytes: 1073741824
  }
}
