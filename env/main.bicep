param sqlServerName string
param adminName string = 'dbadmin'
@secure()
param adminPassword string
param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2021-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    version: '12.0'
    minimalTlsVersion: '1.2'
    administratorLogin: adminName
    administratorLoginPassword: adminPassword
  }
}

resource sqlFirewall 'Microsoft.Sql/servers/firewallRules@2021-11-01-preview' = {
  name: 'AllowAll'
  parent: sqlServer
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}
