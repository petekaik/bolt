[CmdletBinding()]
Param(
    [Parameter(Mandatory = $True)] [Boolean] $Restart
)

Write-Output "Reconfiguring W32Time..."
w32tm /config /syncfromflags:MANUAL /manualpeerlist:"0.nl.pool.ntp.org 1.nl.pool.ntp.org" /update
Write-Output ""
Write-Output "Resyncing clock..."
w32tm /resync
Write-Output ""
Write-Output "Current time source:"
w32tm /query /source
Write-Output ""
Write-Output "All configured time sources:"
w32tm /query /peers

if ($Restart) {
    write-host "Restart parameter enabled, restarting Windows Time service"
    restart-service 'W32Time' -force
    write-host "Windows Time service restarted"
}
