function Set-DirectoryInReverseOrder {
    [cmdletbinding()]
    param ([string]$Directory)

    $dirs = Get-ChildItem -Path $source  | ? { $_.PSIsContainer }
    foreach ($dir in $dirs) {
        Write-Verbose $dir
    }
}
Export-ModuleMember Set-DirectoryInReverseOrder
