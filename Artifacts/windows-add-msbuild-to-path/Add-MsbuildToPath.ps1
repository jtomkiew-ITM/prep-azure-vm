param(
    [string] $version = '15.0'
)

$vsRegPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\SxS\VS7"
$vsRegItemName = $version

$vsInstallPath = (Get-ItemProperty -Path $vsRegPath -Name $vsRegItemName).$vsRegItemName

if (-not $vsInstallPath) {
    throw "VisualStudio $version install path not found"
}
$msbuildPath = $vsInstallPath + "MSBuild\$version\Bin\amd64\"

if (-not (Test-Path $msbuildPath)) {
    throw "MSBuild not found at $msbuildPath"
}

$currentPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

if (-not (($currentPath -like "*$msbuildPath") -or ($currentPath -like "*$msbuildPath;*"))) {
    [Environment]::SetEnvironmentVariable("Path", ($currentPath + ";$msbuildPath"), [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Added '$msbuildPath' to system Path"
} else {
    Write-Host "'$msbuildPath' already exists in system Path"
}
