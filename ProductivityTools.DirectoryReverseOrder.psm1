


function Set-DirectoryInReverseOrder {
    [cmdletbinding()]
    param ([string]$Directory, [int]$LeadingBuffer)

    Write-Output "Hello"
    Write-Output "HelloVerbose"
    $dirs = Get-ChildItem -Path $Directory  | ? { $_.PSIsContainer }
    $count = $dirs.Length + $LeadingBuffer
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

    Write-Output "Hello Remove-Prefix"
    Write-Output "HelloVerbose"
    Write-Verbose "Analyzing directory $Directory"
    $dirs = Get-ChildItem -Path $Directory  | ? { $_.PSIsContainer }
    foreach ($dir in $dirs) {
        Write-Verbose "================"
        $name=$dir.Name
        Write-Verbose $name
        $fourth=$name[3]
        Write-Verbose $fourth
        if ($fourth -eq "_"){
            $numberString=$name.Substring(0,3);
            Write-Verbose($number)
            $number=[int]::Parse($numberString);
            if ($number -gt 0)
            {
                Write-Verbose "We can remove it"
                $newName=$name.Substring(4)
                Write-Verbose "New name: $newName"
                Rename-Item -Path $dir.FullName -NewName $newName
            }
        }

        

        #$count--
    }
}

Export-ModuleMember Set-DirectoryInReverseOrder
Export-ModuleMember Remove-Prefix