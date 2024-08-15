function download_file_dell {
    param (
        [string]$remoteFilePath
    )
    $localDestination = "C:\Users\Lenovo\Downloads\"
    $remoteUser = "zhaoyilun"
    $remoteHost = "<server-ip>"
    $port = <server-port>
    $scpCommand = "scp -P $port ${remoteUser}@${remoteHost}:`"$remoteFilePath`" $localDestination"
    Invoke-Expression $scpCommand
}
