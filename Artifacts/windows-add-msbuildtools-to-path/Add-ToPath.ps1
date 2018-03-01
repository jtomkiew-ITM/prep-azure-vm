param(
    [string] $pathToAdd
)

if (-not (Test-Path $pathToAdd)) {
    throw "Path '$pathToAdd' does not exists"
}

$currentPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

if (-not (($currentPath -like "*$pathToAdd") -or ($currentPath -like "*$pathToAdd;*"))) {
    [Environment]::SetEnvironmentVariable("Path", ($currentPath + ";$pathToAdd"), [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Added '$pathToAdd' to system Path"
} else {
    Write-Host "'$pathToAdd' already exists in system Path"
}
