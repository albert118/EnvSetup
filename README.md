# Windows 10 Developer Machine Setup

Originally a fork of Edi Wang's set up script for new dev machines. You can modify the scripts to fit your own requirements. See Edi Wang [here](https://github.com/EdiWang).

## Prereq's

-   A fresh install of Windows 10 and internet

## Manual Install

1. Download this repo as a zip

> **Optional**: Import "Add_PS1_Run_as_administrator.reg" to your registry to enable context menu on the powershell files to run as Administrator.

2. Run `Install.ps1`.
    > right click and choose run with Powershell...

## Basic Computer Config

-   Set a New Computer Name
-   Disable Sleep on AC Power
-   Throw Cortana out (seriously, it's so annoying to accidentaly trigger her during something important)
-   Remove a few pre-installed Win10 apps.
    -   Messaging, CandyCrush, Bing News, Solitaire, People, Feedback Hub, Your Phone, My Office, FitbitCoach, etc.
-   Install the credentials manager
-   Install Chocolatey for Windows
-   Install the user apps
-   Install Power Tools
-   Install Windows updates
-   `Set-ExecutionPolicy RemoteSigned`

### Dev Config

-   Custom Font: `Fira Code font`
    -   Configures a monospace font ([Fira Code](https://github.com/tonsky/FiraCode))
-   Terminal Preview
-   Docker + Docker Desktop
-   WSL2 + Ubunutu backend
-   `mkdir` for git
-   configure the credentials manager
-   configure some git config defaults (editor, etc.)
-   install vs code
