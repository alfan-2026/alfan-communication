#jalankan dengan: powershell -ExecutionPolicy Bypass -File music_detector.ps1

Add-Type -AssemblyName System.Runtime.WindowsRuntime
$asTaskMethod = [System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.IsGenericMethodDefinition -and $_.GetParameters().Count -eq 1 } | Select-Object -First 1

function Await($AsyncOp, $ResultType) {
    $task = $asTaskMethod.MakeGenericMethod($ResultType).Invoke($null, @($AsyncOp))
    $task.GetAwaiter().GetResult()
}

function Get-TrackInfo {
    try {
        $managerType = [Windows.Media.Control.GlobalSystemMediaTransportControlsSessionManager, Windows.Media, ContentType=WindowsRuntime]
        $mediaPropsType = [Windows.Media.Control.GlobalSystemMediaTransportControlsSessionMediaProperties, Windows.Media, ContentType=WindowsRuntime]
        $mgr = Await ($managerType::RequestAsync()) $managerType
        $session = $mgr.GetCurrentSession()
        
        if ($null -eq $session) { return @{ Status = '0' } }
        
        $playback = $session.GetPlaybackInfo()
        # Mengirim '1' jika Playing, '0' jika tidak
        return @{ Status = if ($playback.PlaybackStatus -eq 'Playing') { '1' } else { '0' } }
    } catch { return @{ Status = '0' } }
}

$port = new-Object System.IO.Ports.SerialPort COM5,115200,None,8,one
$port.Open()

$prevStatus = ''
while ($true) {
    $info = Get-TrackInfo
    if ($info.Status -ne $prevStatus) {
        $port.WriteLine($info.Status) # Kirim sinyal ke ESP32
        Write-Host "Status Terkirim: $($info.Status)" -ForegroundColor Cyan
        $prevStatus = $info.Status
    }
    Start-Sleep -Milliseconds 200
}
