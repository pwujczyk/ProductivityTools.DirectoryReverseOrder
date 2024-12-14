


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

function Remove-Prefix{
    [cmdletbinding()]
    param ([string]$Directory)

    Write-Output "Hello"
    Write-Output "HelloVerbose"
    $dirs = Get-ChildItem -Path $Directory  | ? { $_.PSIsContainer }
    foreach ($dir in $dirs) {

        $fourth=$dir.Name.Substring(3,1)
        Write-Verbose $fourth
        if ($fourth=="_"){
            $name = $dir.Name.Substring(0,4)

        }

        
        Write-Verbose $name
        #Rename-Item -Path $dir.FullName -NewName $targetName

        #$count--
    }
}

Export-ModuleMember Set-DirectoryInReverseOrder
