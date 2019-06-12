$sysmon = sysmon -s | select-string schemaversion=
$sysmonsource = '<set your source location here>'
$sysmonconfig = '<set your xml location here>'

IF ($sysmon.ToString() -eq '<manifest schemaversion="4.21" binaryversion="9.10">') {
    & $sysmonsource -c $sysmonconfig
} ELSE {
    # Uninstall sysmon and re-install new version
    & $sysmonsource -u
    & $sysmonsource -i $sysmonconfig -acceptEula
}