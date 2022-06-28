param sqlServerName string
param sqlDbName string
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
    administrators: {
      administratorType: 'ActiveDirectory'
      principalType: 'Group'
      login: 'SQLServerAdmins'
      sid: 'c223cb4d-4d4f-4f35-933f-dd112f0a1ae4'
      tenantId: 'a8900a0b-29fe-4d22-8251-552c0b6eb399'
    }
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
