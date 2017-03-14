$path = "HKLM:\SOFTWARE\Microsoft\Terminal Server Client"
$name = "AuthenticationLevelOverride"

New-ItemProperty -Path $path -Name $name -Value 0 -PropertyType DWORD -Force