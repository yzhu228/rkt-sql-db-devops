@description('Environment short name.')
param environmentShortName string

@description('Default SQL owner AAD group name.')
param defaultSqlOwnerAadGroupName string

@description('Default SQL owner AAD group object Id.')
param defaultSqlOwnerAadGroupId string

@description('Resource deployment location.')
param location string = resourceGroup().location

/*
------------------------------------------------
Variables
------------------------------------------------
*/

var appName = 'rkt-db-devops'
var userAssignedIdentityName = 'mid-${appName}'
var appUniqueName = '${appName}-${substring(uniqueString(resourceGroup().id), 0, 4)}'
var sqlServerName = 'sql-svr-${appUniqueName}-${toLower(environmentShortName)}'
var dpupSqlServerDatabaseName = 'sql-dbup-db'
var ssdtSqlServerDatabaseName = 'sql-ssdt-db'

var resourceTags = {
  Deployment: 'Azure DevOps RnD'
  Project: 'RKT-SQL-DB-DevOps'
  Environment: toLower(environmentShortName)
}

/*
------------------------------------------------
External References
------------------------------------------------
*/

/*
------------------------------------------------
User Assigned Identities
------------------------------------------------
*/

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {    
  name: userAssignedIdentityName
  location: location
  tags: resourceTags
}

/*
------------------------------------------------
SQL Server
------------------------------------------------
*/

resource sqlServer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: sqlServerName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentity.id}': {}
    }
  }
  tags: resourceTags
  properties: {
    version: '12.0'
    minimalTlsVersion: '1.2'
    primaryUserAssignedIdentityId: userAssignedIdentity.id
    administrators: {
      administratorType: 'ActiveDirectory'
      principalType: 'Group'
      login: defaultSqlOwnerAadGroupName
      sid: defaultSqlOwnerAadGroupId
      tenantId: subscription().tenantId
      azureADOnlyAuthentication: true
    }
  }
}

/*
------------------------------------------------
Firewall Rules
------------------------------------------------
*/

resource symbolicname 'Microsoft.Sql/servers/firewallRules@2021-08-01-preview' = {
  name: 'allowAzureFirewallRule'
  parent: sqlServer
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}

/*
------------------------------------------------
SQL Databases
------------------------------------------------
*/

resource dpupSqlServerDatabase 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  name: dpupSqlServerDatabaseName
  parent: sqlServer
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 10
  }
  tags: resourceTags
  properties: {
    collation: 'Latin1_General_CI_AS'
    maxSizeBytes: 10737418240
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
  }
}

resource ssdtSqlServerDatabase 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  name: ssdtSqlServerDatabaseName
  parent: sqlServer
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 10
  }
  tags: resourceTags
  properties: {
    collation: 'Latin1_General_CI_AS'
    maxSizeBytes: 10737418240
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
  }
}

output sqlServerFqdn string = '${sqlServerName}${environment().suffixes.sqlServerHostname}'
output dpupSqlServerDatabaseName string = dpupSqlServerDatabaseName
output ssdtSqlServerDatabaseName string = ssdtSqlServerDatabaseName
