# -----------------------------------------------------------------------------

$userApps = @(
    "steam"
    "plex"
    "spotify",
    "powertoys", # Windows PowerToys
    "googlechrome",
    "firefox",
    # "opera"
    "zotero",
     "msiafterburner"
    "7zip.install",
    # "samsung-magician"
    "discord",
    "hwinfo"
    # "via" # for keyboard config loading
)

# -----------------------------------------------------------------------------
function InstallApps([string[]]$Apps)
{
    foreach ($app in $Apps) {
        choco install $app -y
    }
}

# -----------------------------------------------------------------------------

Write-Host "Installing user apps" -ForegroundColor Green
InstallApps -Apps $userApps
Write-Host "User app installation completed" -ForegroundColor Green;
Write-Host "Please review the productivity and entertainment installation is as expected. A restart will be required to ensure some apps register as expected." -ForegroundColor Yellow;
