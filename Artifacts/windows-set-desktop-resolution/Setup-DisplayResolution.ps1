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
    New-ItemProperty -Path $monitorItem.PSPath -Name 'DefaultSettings.XResolution' -Value 1600 -PropertyType DWORD -Force
    New-ItemProperty -Path $monitorItem.PSPath -Name 'DefaultSettings.YResolution' -Value 1000 -PropertyType DWORD -Force
}
else {
    Write-Host 'No monitor item found!'
}

# Set-DisplayResolution -Width 1920 -Height 1200 -Force # did not work