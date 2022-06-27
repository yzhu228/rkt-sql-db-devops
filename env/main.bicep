param adminName string = 'dbadmin'
@secure()
param adminPassword string
param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2021-11-01-preview' = {
  name: 'yzlab-datahost1'
  location: location
  properties: {
    version: '12.0'
    minimalTlsVersion: '1.2'
    administratorLogin: adminName
    administratorLoginPassword: adminPassword
  }
}
