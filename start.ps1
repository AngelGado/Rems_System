param(
    [string]$ListenAddress = "127.0.0.1"
)

Set-Location $PSScriptRoot

$credential = Import-Clixml "$env:LOCALAPPDATA\REMS\db-credentials.xml"

$env:REMS_DB_DSN = 'mysql:host=127.0.0.1;port=3306;dbname=rems_test_db;charset=utf8mb4'
$env:REMS_DB_USER = $credential.UserName
$env:REMS_DB_PASSWORD = $credential.GetNetworkCredential().Password

php -r "require 'includes/database.php'; echo remsDatabase()->query('SELECT DATABASE()')->fetchColumn(), PHP_EOL;"

if ($LASTEXITCODE -ne 0) {
    throw "Database connection failed."
}

php -S "${ListenAddress}:8081" router.php