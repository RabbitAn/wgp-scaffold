@echo off
setlocal
set "SCRIPT_DIR=%~dp0"

if /i "%~1"=="new" (
    powershell -ExecutionPolicy Bypass -File "%SCRIPT_DIR%New-Project.ps1" %2 %3 %4 %5 %6
    goto :eof
)

if /i "%~1"=="version" (
    echo wgp scaffold v1.0.0
    goto :eof
)

echo.
echo WGP Scaffold CLI - Generate ABP projects from template
echo.
echo Usage:
echo   wgp new ^<ProjectName^>              Create project in current directory
echo   wgp new ^<ProjectName^> -o ^<Path^>    Create project in specified directory
echo   wgp version                        Show version
echo.
echo Examples:
echo   wgp new MyApp
echo   wgp new MyApp -o D:\Projects
echo   wgp new OrderService -o E:\Solutions
echo.

endlocal