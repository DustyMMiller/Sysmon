$sysmon = sysmon -s | select-string schemaversion=
$sysmonsource = '<set your source location here>'
$sysmonconfig = '<set your xml location here>'
$sysmonstring = '<manifest schemaversion="4.23" binaryversion="9.20">'

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

$maxlength = Get-WinEvent -ListLog Microsoft-Windows-Sysmon/Operational
IF ($maxlength -ne 524288000) {
    $maxlength.MaximumSizeInBytes = 524288000
    $maxlength.SaveChanges()
}
