New-Item -Type SymbolicLink $HOME\.gitconfig -Value $PSScriptRoot\.gitconfig
New-Item -Type SymbolicLink $HOME\.commit_template -Value $PSScriptRoot\.commit_template
New-Item -Type SymbolicLink $HOME\.gitignore_global $PSScriptRoot\.gitignore_global
