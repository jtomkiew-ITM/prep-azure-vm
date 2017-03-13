$Profile = Get-NetConnectionProfile -InterfaceAlias Ethernet*
$profile[0].NetworkCategory = "Private"
Set-NetConnectionProfile -InputObject $Profile

netsh advfirewall firewall add rule name="File and Printer Sharing (SMB-In)" dir=in action=allow program=System profile=private localport=445 protocol=tcp