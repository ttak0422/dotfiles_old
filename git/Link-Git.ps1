Get-ChildItem -Path $PSScriptRoot\.* | ForEach-Object{
    $targetPath = $PSScriptRoot + '\' + $_.Name
    $symbolicPath = $HOME + '\' + $_.Name
    if (-Not(Test-Path $symbolicPath)) {
        New-Item -Type SymbolicLink $symbolicPath -Value $targetPath
        # Verbose?
        Write-Output "'$symbolicPath' => '$targetPath}'"
    }
}