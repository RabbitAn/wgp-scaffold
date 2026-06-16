# WGP Scaffold Uninstaller
#
# Removes wgp from ~/.wgp and from user PATH.

$InstallDir = Join-Path $env:USERPROFILE ".wgp"

Write-Host "Uninstalling wgp..." -ForegroundColor Yellow

# Remove install directory
if (Test-Path $InstallDir) {
    Remove-Item $InstallDir -Recurse -Force
    Write-Host "Removed: $InstallDir" -ForegroundColor Gray
}

# Remove from PATH
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath) {
    $NewPath = ($UserPath -split ";" | Where-Object { $_ -ne $InstallDir }) -join ";"
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    Write-Host "Removed from PATH" -ForegroundColor Gray
}

Write-Host "Uninstalled. Please restart your terminal." -ForegroundColor Green