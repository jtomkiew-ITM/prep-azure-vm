param(
	[string]$directory
)

if ($directory) {
    mkdir "C:\$directory"
}

$Profile = Get-NetConnectionProfile -InterfaceAlias Ethernet*
$profile[0].NetworkCategory = "Private"
Set-NetConnectionProfile -InputObject $Profile

netsh advfirewall firewall add rule name="File and Printer Sharing (SMB-In)" dir=in action=allow program=System profile=private localport=445 protocol=tcp

# netsh firewall set service type=FILEANDPRINT mode=ENABLE profile=STANDARD # deprecated
# netsh advfirewall firewall set rule name="File and Printer Sharing (SMB-In)" profile=private new enable=yes # might not exist
# netsh advfirewall firewall set rule group="network discovery" new enable=yes # unnecessary