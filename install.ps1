# WGP Scaffold Installer
#
# Installs the `wgp` CLI from GitHub into ~/.wgp and adds it to user PATH.
#
# One-line install (replace OWNER and REPO with your GitHub values):
#   $owner="OWNER"; $repo="REPO"; irm "https://raw.githubusercontent.com/$owner/$repo/main/install.ps1" | iex
#
# After install, RESTART your terminal, then run:
#   wgp new MyApp

param(
    # GitHub repository owner (change to your own)
    [string]$RepoOwner = "RabbitAn",

    # GitHub repository name
    [string]$RepoName = "wgp-scaffold",

    # Branch to install from
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "WGP Scaffold Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Install location: %USERPROFILE%\.wgp
$InstallDir = Join-Path $env:USERPROFILE ".wgp"
Write-Host "Installing to: $InstallDir" -ForegroundColor Gray

# Clean previous install
if (Test-Path $InstallDir) {
    Write-Host "Removing previous installation..." -ForegroundColor Gray
    Remove-Item $InstallDir -Recurse -Force
}
New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null

# Download repository as zip
$ZipUrl = "https://github.com/$RepoOwner/$RepoName/archive/refs/heads/$Branch.zip"
$ZipPath = Join-Path $env:TEMP "wgp-scaffold.zip"

Write-Host "Downloading from $ZipUrl ..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing
} catch {
    Write-Error "Download failed. Check your network or repository URL."
    Write-Host "Repo: https://github.com/$RepoOwner/$RepoName (branch: $Branch)" -ForegroundColor Yellow
    exit 1
}

# Extract
$ExtractDir = Join-Path $env:TEMP "wgp-scaffold-extract"
if (Test-Path $ExtractDir) { Remove-Item $ExtractDir -Recurse -Force }
Expand-Archive -Path $ZipPath -DestinationPath $ExtractDir -Force

# The zip contains a single root folder like "wgp-scaffold-main"
$RootFolder = Get-ChildItem -Path $ExtractDir -Directory | Select-Object -First 1

if (-not $RootFolder) {
    Write-Error "Unexpected archive structure."
    exit 1
}

# Copy all contents to install dir
Copy-Item -Path (Join-Path $RootFolder.FullName "*") -Destination $InstallDir -Recurse -Force

# Clean up temp files
Remove-Item $ZipPath -Force
Remove-Item $ExtractDir -Recurse -Force

# Add to user PATH
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (-not $UserPath) { $UserPath = "" }

if ($UserPath -split ";" -notcontains $InstallDir) {
    $NewPath = if ($UserPath) { "$UserPath;$InstallDir" } else { $InstallDir }
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    Write-Host "Added to user PATH" -ForegroundColor Green
} else {
    Write-Host "Already in PATH" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "IMPORTANT: Restart your terminal for 'wgp' to become available." -ForegroundColor Yellow
Write-Host ""
Write-Host "Then run:" -ForegroundColor White
Write-Host "  wgp new MyApp              # create in current directory"
Write-Host "  wgp new MyApp -o D:\Projects"
Write-Host ""