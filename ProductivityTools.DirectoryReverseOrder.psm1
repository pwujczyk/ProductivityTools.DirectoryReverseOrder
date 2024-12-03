


function Set-DirectoryInReverseOrder {
    [cmdletbinding()]
    param ([string]$Directory)

    Write-Output "Hello"
    Write-Output "HelloVerbose"
    $dirs = Get-ChildItem -Path $Directory  | ? { $_.PSIsContainer }
    $count = $dirs.Length
    foreach ($dir in $dirs) {
        $number = '{0:d3}' -f $count
        $targetName = $number + "_" + $dir.Name
        Write-Verbose $targetName
        Rename-Item -Path $dir.FullName -NewName $targetName

        $count--
    }
}
Export-ModuleMember Set-DirectoryInReverseOrder
