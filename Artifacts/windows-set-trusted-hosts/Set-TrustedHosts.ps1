param(
    [string]$value
)

Set-Item WSMan:\localhost\Client\TrustedHosts -Value "$value" -Force

Get-Item WSMan:\localhost\Client\TrustedHosts