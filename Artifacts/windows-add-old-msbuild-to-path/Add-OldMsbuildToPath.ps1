param(
    [string]$version = '14.0'
)

$msbuildRegPath = "HKLM:\SOFTWARE\Microsoft\MSBuild\ToolsVersions\$version"
$msbuildRegItemName = "MSBuildToolsPath"

$msbuildPath = (Get-ItemProperty -Path $msbuildRegPath -Name $msbuildRegItemName).$msbuildRegItemName

if (-not $msbuildPath) {
    throw "MSBuild path not found"
}

$currentPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

if (-not (($currentPath -like "*$msbuildPath") -or ($currentPath -like "*$msbuildPath;*"))) {
    [Environment]::SetEnvironmentVariable("Path", ($currentPath + ";$msbuildPath"), [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Added '$msbuildPath' to system Path"
} else {
    Write-Host "'$msbuildPath' already exists in system Path"
}
