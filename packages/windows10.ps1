function EnableAllowConfirmation()
{
    choco feature enable --name=allowGlobalConfirmation
}

function DisableAllowConfirmation()
{
    choco feature disable --name=allowGlobalConfirmation
}

function InstallBrowserApps()
{
    choco install GoogleChrome --limit-output
    choco pin add --name GoogleChrome --limit-output
}

function InstallFonts()
{
    choco install firacode --limit-output
}

function InstallDevTools()
{
    choco install git --limit-output
    
    choco install vscode --limit-output
    choco pin add --name vscode --limit-output

    choco install jetbrainstoolbox --limit-output
    choco pin add --name jetbrainstoolbox --limit-output

    choco install typora --limit-output
    choco pin add --name typora --limit-output

    choco install unity-hub --limit-output

    choco install dotnetcore-sdk --limit-output
}

if (-not(([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"`
    ))) {
    Write-Output "Must be run with authentication rights"
    exit
}

EnableAllowConfirmation
InstallBrowserApps

InstallDevTools
DisableAllowConfirmation

function InstallFlutter()
{
    if(!(Test-Path $HOME\flutter))
    {
        Write-Output "Install Flutter"
        git clone https://github.com/flutter/flutter.git $HOME\flutter
    } else {
        Write-Output "Already installed flutter"
    }
}

InstallFlutter