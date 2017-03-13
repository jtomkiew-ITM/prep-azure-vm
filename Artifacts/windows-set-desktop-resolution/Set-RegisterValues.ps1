param(
    [int]$Width = 1600,
    [int]$Height =1000
)

$controlSets = Get-ChildItem 'HKLM:\SYSTEM' | Where-Object {$_.Name -like '*ControlSet*'}
$cards = New-Object 'System.Collections.Generic.List[System.MarshalByRefObject]'
$basicDisplays = New-Object 'System.Collections.Generic.List[System.MarshalByRefObject]'
foreach($cs in $controlSets) {
    $csCards = Get-ChildItem ($cs.PSPath + '\Hardware Profiles\UnitedVideo\CONTROL\VIDEO') | Where-Object {$_.Name -like '*\{*}'}
    foreach($card in $csCards) {
        $cards.Add($card)
    }
    $csBDs = Get-ChildItem ($cs.PSPath + '\Hardware Profiles\UnitedVideo\SERVICES') | Where-Object {$_.Name -like '*\BASICDISPLAY'}
    foreach($bd in $csBDs) {
        $basicDisplays.Add($bd)
    }
}

$displays = New-Object 'System.Collections.Generic.List[System.MarshalByRefObject]'
foreach($card in $cards) {
    $cardDisplays = Get-ChildItem $card.PSPath | Where-Object {$_.Name -match '\d\d\d\d'}
    foreach($display in $cardDisplays) {
        $displays.Add($display)
    }
}

$monitors = New-Object 'System.Collections.Generic.List[System.MarshalByRefObject]'
foreach($display in $displays) {
    $displayMonitors = Get-ChildItem $display.PSPath | Where-Object {$_.Name -like '*\Mon*'}
    foreach($monitor in $displayMonitors) {
        $monitors.Add($monitor)
    }
}

$xresolution = 'DefaultSettings.XResolution'
$yresolution = 'DefaultSettings.YResolution'

$items = $displays + $monitors + $basicDisplays
foreach($item in $items) {
    Write-Output ($item.PSPath)
    if((Get-ItemProperty -Path $item.PSPath -Name $xresolution).$xresolution -ne $Width) {
        New-ItemProperty -Path $item.PSPath -Name $xresolution -Value $Width -PropertyType DWORD -Force | Out-Null
        Write-Output ('    Changed width to ' + $Width)
    }
    if((Get-ItemProperty -Path $item.PSPath -Name $yresolution).$yresolution -ne $Height) {
        New-ItemProperty -Path $item.PSPath -Name $yresolution -Value $Height -PropertyType DWORD -Force | Out-Null
        Write-Output ('    Changed height to ' + $Height)
    }
}