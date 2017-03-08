param(
	[string]$directory
)

if ($directory) {
    mkdir "C:\$directory"
}

$Profile = Get-NetConnectionProfile -InterfaceAlias Ethernet*
$profile[0].NetworkCategory = "Private"
Set-NetConnectionProfile -InputObject $Profile

# netsh firewall set service type=FILEANDPRINT mode=ENABLE profile=STANDARD # deprecated
netsh advfirewall firewall set rule name="File and Printer Sharing (SMB-In)" profile=private new enable=yes

# netsh advfirewall firewall set rule group="network discovery" new enable=yes # unnecessary