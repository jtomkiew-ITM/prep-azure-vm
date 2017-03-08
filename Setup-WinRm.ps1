$ipv4 = (Test-Connection -ComputerName (hostname) -Count 1  | Select IPV4Address).IPV4Address.IPAddressToString
.\ConfigureWinRM.ps1 -HostName $ipv4