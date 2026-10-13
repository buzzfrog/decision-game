param([int]$Port = 8080)

$root = $PSScriptRoot
$python = Get-Command python -ErrorAction SilentlyContinue

if ($python) {
    # A fixed http://localhost origin keeps saved settings (localStorage) stable between runs
    $url = "http://localhost:$Port/index.html"
    $server = Start-Process python -ArgumentList "-m", "http.server", $Port, "--directory", "`"$root`"" -NoNewWindow -PassThru

    $ready = $false
    for ($i = 0; $i -lt 50 -and -not $ready; $i++) {
        try {
            Invoke-WebRequest $url -UseBasicParsing -TimeoutSec 1 | Out-Null
            $ready = $true
        } catch {
            Start-Sleep -Milliseconds 200
        }
    }

    Start-Process $url
    Write-Host "Serving on $url - press Ctrl+C to stop"
    try { $server.WaitForExit() } finally { if (-not $server.HasExited) { Stop-Process -Id $server.Id } }
} else {
    Start-Process (Join-Path $root "index.html")
}
