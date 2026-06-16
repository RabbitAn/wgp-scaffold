# WGP Scaffold - Generate a new ABP project from template
#
# Usage:
#   wgp new <ProjectName>            # create in current directory
#   wgp new <ProjectName> -o <Path>  # create in specified directory
#
# Examples:
#   wgp new MyApp
#   wgp new MyApp -o D:\Projects
#   wgp new OrderService -o E:\Solutions

param(
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Project name, e.g. MyApp")]
    [ValidatePattern('^[A-Za-z][A-Za-z0-9]*$')]
    [string]$ProjectName,

    [Parameter(Position = 1, HelpMessage = "Output directory (default: current directory)")]
    [Alias('o', 'output')]
    [string]$OutputPath
)

# Default output path = current directory
if (-not $OutputPath) {
    $OutputPath = $PWD.Path
}

# Template path (same directory as this script)
$templatePath = Join-Path $PSScriptRoot "template"

# Check template exists
if (-not (Test-Path $templatePath)) {
    Write-Error "Template not found: $templatePath"
    Write-Host "Please reinstall wgp: irm https://raw.githubusercontent.com/<owner>/<repo>/main/install.ps1 | iex" -ForegroundColor Yellow
    exit 1
}

# Target path
$targetPath = Join-Path $OutputPath $ProjectName

# Check target exists
if (Test-Path $targetPath) {
    Write-Error "Target already exists: $targetPath"
    Write-Host "Use a different project name or output path." -ForegroundColor Yellow
    exit 1
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "WGP Scaffold Generator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Copy template
Write-Host "[1/3] Copying template..." -ForegroundColor Green
Copy-Item -Path $templatePath -Destination $targetPath -Recurse -Force
Write-Host "     -> $targetPath" -ForegroundColor Gray

# Step 2: Replace content
Write-Host "[2/3] Replacing content (BoxAssembly -> $ProjectName)..." -ForegroundColor Green

$fileCount = 0
$files = Get-ChildItem -Path $targetPath -Recurse -File

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    if ($content -and ($content -match 'BoxAssembly')) {
        $newContent = $content -replace 'BoxAssembly', $ProjectName
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8 -NoNewline
        $fileCount++
    }
}

Write-Host "     Processed $fileCount files" -ForegroundColor Gray

# Step 3: Rename files and folders
Write-Host "[3/3] Renaming files and folders..." -ForegroundColor Green

$itemsToRename = Get-ChildItem -Path $targetPath -Recurse |
    Where-Object { $_.Name -match 'BoxAssembly' } |
    Sort-Object { $_.FullName.Length } -Descending

$renameCount = 0
foreach ($item in $itemsToRename) {
    $newName = $item.Name -replace 'BoxAssembly', $ProjectName
    Rename-Item -Path $item.FullName -NewName $newName -Force
    $renameCount++
}

Write-Host "     Renamed $renameCount items" -ForegroundColor Gray

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Done! Project created successfully" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Location: $targetPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  cd $targetPath"
Write-Host "  dotnet restore"
Write-Host "  dotnet build"
Write-Host "  dotnet run --project $ProjectName.Web"
Write-Host ""