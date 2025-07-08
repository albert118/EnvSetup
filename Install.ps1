if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; 
    exit;
}

function Get-logicalYesNo([string]$question) {
do { $sAnswer = Read-Host "$question [Y/N]" } until ($sAnswer.ToUpper()[0] -match '[yYnN]') -ForegroundColor Yellow;
    return ($sAnswer.ToUpper()[0] -match '[Y]') #return  $True or $False
}

# -----------------------------------------------------------------------------
# Source script variables

$configureSystemPreferences = $PSScriptRoot + "\configure-system-preferences.ps1";
$removeUwpApps = $PSScriptRoot + "\remove-uwp-apps.ps1";
$setUpChoco = $PSScriptRoot + "\setup-choco.ps1";
$installDevDependencies = $PSScriptRoot + "\install-dev-deps.ps1";
$installUtilities = $PSScriptRoot + "\install-utilities.ps1";
$installUserApps = $PSScriptRoot + "\install-user-apps.ps1";
$checkWindowsUpdates = $PSScriptRoot + "\check-windows-updates.ps1";
$removeCortanaAndBing = $PSScriptRoot + "\remove-cortana-and-bing.ps1";

# -----------------------------------------------------------------------------
# Get user preferences before starting

Write-Host ""
Write-Host "Configure Prefrences:" -ForegroundColor Green;
Write-Host "------------------------------------" -ForegroundColor Green;

$shouldInstallDevDeps = Get-logicalYesNo("Install development depenendies?")
$shouldInstallUtilities = Get-logicalYesNo("Install debugging utilties (Wireshark, etc.)?")
$willRestart = Get-logicalYesNo("Auto Restart once script completed?")

# -----------------------------------------------------------------------------
# Run scripts

& $setUpChoco;
& $configureSystemPreferences;
& $removeUwpApps;
& $removeCortanaAndBing

Write-Host ""
Write-Host "Installing Applications" -ForegroundColor Green;
Write-Host "------------------------------------" -ForegroundColor Green;

& $installUserApps;

if ($shouldInstallDevDeps) {
    & $installDevDependencies;
}

if ($shouldInstallUtilities) {
    & $installUtilities;
}

# Updates take a long time, check these last
& $checkWindowsUpdates;

# -----------------------------------------------------------------------------
Write-Host "------------------------------------" -ForegroundColor Green;
Read-Host -Prompt "Setup is done, a restart is required";

if ($willRestart) {
    Write-Host -NoNewLine "Restarting in 20s";
    Start-Sleep -Seconds 20
    Restart-Computer;
} else {
    Write-Host -NoNewLine "Computer will restart on next keystroke - do so once you've reviewed the logs";
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    Restart-Computer;
}