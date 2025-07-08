# -----------------------------------------------------------------------------
# Disable the  "Get fun facts, tips and more from Windows and Cortana on your lock screen"

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0

# -----------------------------------------------------------------------------
# Disable and remove Cortana

Write-Host "Removing Cortana" -ForegroundColor Green

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0  

# Windows 1903 and later
# Disable cortana completely across windows. See: https://www.ubergizmo.com/how-to/disable-bing-search-windows-10/
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'CortanaConsent' -Value 0 -PropertyType DWORD -Force

Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage

# -----------------------------------------------------------------------------
# Disable Bing Search

Write-Host "Disabling Bing serach (taskbar web searching and 'suggestions'), this also includes the Windows Explorer web searching integration" -ForegroundColor Green

# For Windows 11 Preview build 20000.  https://www.youtube.com/watch?v=Td9AWfdtodI
# Also For Windows 10 version 2004 or later. From: https://www.bennetrichter.de/en/tutorials/windows-10-disable-web-search/
if (!(Get-Item -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -ErrorAction SilentlyContinue)) {
    New-Item -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
}

if (!(Get-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -ErrorAction SilentlyContinue)) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
}

New-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'DisableSearchBoxSuggestions' -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'DisableSearchBoxSuggestions' -Value 1 -PropertyType DWORD -Force

# 1903 and later, applies to Microsoft and local user accounts
# Need to do this for Microsoft Accounts on 21H1: https://www.ubergizmo.com/how-to/disable-bing-search-windows-10/
# Need to do this for Microsoft Accounts on 1903
# Apply to current MS account
if (!(Get-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -ErrorAction SilentlyContinue)) {
    New-Item Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search'
}

If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {  
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null  
}  

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0  
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Value 0 -PropertyType DWORD -Force
