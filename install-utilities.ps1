# -----------------------------------------------------------------------------

$utilities = @(
    "putty"
    "pingplotter"
    "wireshark"
    "windirstat"
    "wget"
    "openssl.light"
    "hfsexplorer"
)


# -----------------------------------------------------------------------------
function InstallApps([string[]]$Apps)
{
    foreach ($app in $Apps) {
        choco install $app -y
    }
}

# -----------------------------------------------------------------------------

Write-Host "Setting up utilities" -ForegroundColor Green
InstallApps -Apps $utilities

Write-Host "Utility installation compeleted" -ForegroundColor Green;
