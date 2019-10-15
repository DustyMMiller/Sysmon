$sysmon = sysmon -s | select-string schemaversion=
$sysmonsource = '<set your source location here>'
$sysmonconfig = '<set your xml location here>'
$sysmonstring = '<manifest schemaversion="4.21" binaryversion="9.10">'

IF ($sysmon.ToString() -eq $sysmonstring) {
    & $sysmonsource -c $sysmonconfig
} ELSE {
    # Uninstall sysmon and re-install new version
    sysmon -u
    & $sysmonsource -i $sysmonconfig -acceptEula
}
