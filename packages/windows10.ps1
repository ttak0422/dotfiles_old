# 以後，インストールに関する認証を省略できるようにする．
function EnableAllowConfirmation()
{
    choco feature enable --name=allowGlobalConfirmation
}

# 以後，インストールに関する認証を省略できないようにする．
function DisableAllowConfirmation()
{
    choco feature disable --name=allowGlobalConfirmation
}

# ブラウザ関連のアプリのhインストール
function InstallBrowserApps()
{
    <# Chromeのインストールを行う
       --limit-outputはターミナルに出力される情報を必要なものに制限させるオプションです． #>
    choco install GoogleChrome --limit-output
    # Chromeのバージョン更新をchocolateyで行わないように指示するコマンドです．
    choco pin add --name GoogleChrome --limit-output
}

# Fontのインストール
function InstallFonts()
{
    choco install firacode --limit-output
}

# 開発ツールのインストール
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

<# EntryPoint
   管理者権限で実行されていない場合終了する #>
if (-not(([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"`
    ))) {
    echo "管理者権限で実行する必要があります"
    exit
}

EnableAllowConfirmation
InstallBrowserApps
InstallFonts
InstallDevTools
DisableAllowConfirmation