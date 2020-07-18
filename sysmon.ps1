$sysmon = sysmon -s | select-string "System Monitor v"
$sysmonsource = '<set your source location here>'
$sysmonconfig = '<set your xml location here>'
$sysmonstring = '<set the response from $sysmon above>'
# example 'System Monitor v11.10 - System activity monitor'
$filePath = 'C:\Windows\Sysmon.exe'
# or path to where you install sysmon if different

IF (Test-Path $filePath) {
    IF ($sysmon.ToString() -eq $sysmonstring) {
        & $sysmonsource -c $sysmonconfig
    } ELSE {
        # Uninstall sysmon and re-install new version
        sysmon -u
        & $sysmonsource -i $sysmonconfig -acceptEula
    }
} ELSE {
    & $sysmonsource -i $sysmonconfig -acceptEula
}

<# Below is an example of how to increase the size of sysmon logs
This will set the maxsize to 500MB
Remove the comments if you want to use it #>
<# $maxlength = Get-WinEvent -ListLog Microsoft-Windows-Sysmon/Operational
IF ($maxlength -ne 524288000) {
    $maxlength.MaximumSizeInBytes = 524288000
    $maxlength.SaveChanges()
} #>