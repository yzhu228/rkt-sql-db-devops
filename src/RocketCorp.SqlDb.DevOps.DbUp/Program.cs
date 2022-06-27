using DbUp;
using DbUp.Engine;
using DbUp.Support;
using System.Reflection;

// Supports for Local Database
var connectionString =
        args.FirstOrDefault()
        ?? "Server=(local)\\SqlExpress; Database=rkt-dbup-devops; Trusted_connection=true";

var upgradeEngineBuilder = DeployChanges.To
                // Supports Azure Sql Integrated Security
                .SqlDatabase(connectionString, "dbo")
                // First, Runs Schema Changes Once
                .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), x => x.StartsWith("RocketCorp.SqlDb.DevOps.DbUp.Scripts.Schema"), new SqlScriptOptions { ScriptType = ScriptType.RunOnce, RunGroupOrder = 0 })
                // Followed by Data like Lookup and Mappings
                .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), x => x.StartsWith("RocketCorp.SqlDb.DevOps.DbUp.Scripts.Data"), new SqlScriptOptions { ScriptType = ScriptType.RunOnce, RunGroupOrder = 1 })
                // Followed by Views, Runs Changes Always
                .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), x => x.StartsWith("RocketCorp.SqlDb.DevOps.DbUp.Scripts.Views"), new SqlScriptOptions { ScriptType = ScriptType.RunAlways, RunGroupOrder = 2 })
                // Followed by SPs, Runs Changes Always
                .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), x => x.StartsWith("RocketCorp.SqlDb.DevOps.DbUp.Scripts.StoredProcedures"), new SqlScriptOptions { ScriptType = ScriptType.RunAlways, RunGroupOrder = 3 })
                .WithTransactionPerScript()
                .LogToConsole();

var upgrader = upgradeEngineBuilder.Build();

Console.WriteLine("Is upgrade required: " + upgrader.IsUpgradeRequired());

var result = upgrader.PerformUpgrade();

// Display the result
if (result.Successful)
{
    Console.ForegroundColor = ConsoleColor.Green;
    Console.WriteLine("Success!");
}
else
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine(result.Error);
    Console.WriteLine("Failed!");
}
