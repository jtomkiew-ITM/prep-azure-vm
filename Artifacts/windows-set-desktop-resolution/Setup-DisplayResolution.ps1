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

$controlSets = Get-ChildItem 'HKLM:\SYSTEM' | Where-Object {$_.Name -like '*ControlSet*'}
$cards = New-Object 'System.Collections.Generic.List[System.MarshalByRefObject]'
foreach($cs in $controlSets) {
    $csCards = Get-ChildItem ($cs.PSPath + '\Hardware Profiles\UnitedVideo\CONTROL\VIDEO') | Where-Object {$_.Name -like '*\{*}'}
    foreach($card in $csCards) {
        $cards.Add($card)
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

$items = $displays + $monitors
foreach($item in $items) {
    New-ItemProperty -Path $item.PSPath -Name 'DefaultSettings.XResolution' -Value $Width -PropertyType DWORD -Force
    New-ItemProperty -Path $item.PSPath -Name 'DefaultSettings.YResolution' -Value $Height -PropertyType DWORD -Force
}