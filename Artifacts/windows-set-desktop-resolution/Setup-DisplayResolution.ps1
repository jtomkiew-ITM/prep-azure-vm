param(
	[int]$Width,
    [int]$Height
)
if (-not $Width) {
    throw "Parameter '-Width' is required."
}
if (-not $Height) {
    throw "Parameter '-Height' is required."
}

$items = Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Hardware Profiles\UnitedVideo\CONTROL\VIDEO'
$monitorItem = $false
foreach($item in $items) {
    $target = Get-ChildItem ($item.PSPath + '\0000')
    if ($target) {
        $monitorItem = $target
        Write-Host $target
    }
    else {
        Write-Host $item
    }
}

if ($monitorItem) {
    New-ItemProperty -Path $monitorItem.PSPath -Name 'DefaultSettings.XResolution' -Value $Width -PropertyType DWORD -Force
    New-ItemProperty -Path $monitorItem.PSPath -Name 'DefaultSettings.YResolution' -Value $Height -PropertyType DWORD -Force
}
else {
    Write-Host 'No monitor item found!'
}

# Set-DisplayResolution -Width $Width -Height $Height -Force # does not work