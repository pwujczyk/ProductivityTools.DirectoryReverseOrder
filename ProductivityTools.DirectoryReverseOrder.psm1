<#
.SYNOPSIS
    Provides functions to add and remove numerical prefixes to directory names to control sort order.

.DESCRIPTION
    This module contains functions to manage the sort order of directories by prepending or removing numerical prefixes.
    This is useful for reversing the default alphabetical sort order in file explorers.

    - Set-DirectoryInReverseOrder: Adds a descending numerical prefix (e.g., 003_, 002_, 001_) to subdirectories.
    - Remove-PrefixFromDirectoryName: Removes a previously added numerical prefix.

.NOTES
    Author: Pawel Wujczyk
#>

function Set-DirectoryInReverseOrder {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [ValidateScript({ Test-Path -Path $_ -PathType Container })]
        [string]$Directory = ".",

        [Parameter(Mandatory = $false)]
        [int]$LeadingBuffer = 0
    )

    <#
    .SYNOPSIS
        Adds a descending numerical prefix to subdirectories to reverse their sort order.
    .DESCRIPTION
        This function gets all subdirectories in a specified path, sorts them by name, and then renames each one by prepending a 3-digit number in descending order.
        This causes file explorers to display the last directory first.
    .PARAMETER Directory
        The path to the parent directory whose subdirectories will be renamed. Defaults to the current location.
    .PARAMETER LeadingBuffer
        An integer value that provides a buffer for the starting number. The numbering will start from (number of directories + LeadingBuffer).
        This is useful if you plan to add more directories later and want to avoid renumbering everything.
    .EXAMPLE
        Set-DirectoryInReverseOrder -Path "C:\Photos" -Verbose
        This command will add prefixes to all subdirectories inside C:\Photos.
    .EXAMPLE
        Get-Item "C:\Projects" | Set-DirectoryInReverseOrder -WhatIf
        This command previews the renaming of subdirectories in C:\Projects without actually performing the action.
    #>
    try {
        $dirs = Get-ChildItem -Path $Directory -Directory | Sort-Object Name
        $count = $dirs.Length + $LeadingBuffer
        foreach ($dir in $dirs) {
            # Skip directories that already have a prefix
            if ($dir.Name -match '^\d{3}_') {
                Write-Verbose "Skipping already prefixed directory: $($dir.Name)"
                $count--
                continue
            }

            $number = '{0:d3}' -f $count
            $targetName = "$($number)_$($dir.Name)"

            if ($PSCmdlet.ShouldProcess($dir.FullName, "Rename to '$targetName'")) {
                Rename-Item -Path $dir.FullName -NewName $targetName -ErrorAction Stop
            }
            $count--
        }
    }
    catch {
        Write-Error "An error occurred in Set-DirectoryInReverseOrder: $_"
    }
}

function Remove-PrefixFromDirectoryName {
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Remove-DirectoryPrefix')]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [ValidateScript({ Test-Path -Path $_ -PathType Container })]
        [string]$Directory = "."
    )
    <#
    .SYNOPSIS
        Removes the numerical prefix (XXX_) from directory names.
    .DESCRIPTION
        This function scans all subdirectories in a given path and removes any prefix that matches the 'NNN_' pattern at the beginning of the name.
    .PARAMETER Directory
        The path to the parent directory whose subdirectories will be processed. Defaults to the current location.
    .EXAMPLE
        Remove-PrefixFromDirectoryName -Path "C:\Photos" -Verbose
        This command will remove the numerical prefix from all subdirectories in C:\Photos.
    .EXAMPLE
        'C:\Photos' | Remove-DirectoryPrefix -Confirm
        This command will prompt for confirmation before removing the prefix from each directory.
    #>
    try {
        Write-Verbose "Analyzing directory '$Directory' for prefixes to remove."
        $dirs = Get-ChildItem -Path $Directory -Directory
        foreach ($dir in $dirs) {
            if ($dir.Name -match '^\d{3}_') {
                $newName = $dir.Name.Substring(4)
                if ($PSCmdlet.ShouldProcess($dir.FullName, "Rename to '$newName'")) {
                    Rename-Item -Path $dir.FullName -NewName $newName -ErrorAction Stop
                }
            }
            else {
                Write-Verbose "Skipping directory without a valid prefix: $($dir.Name)"
            }
        }
    }
    catch {
        Write-Error "An error occurred in Remove-PrefixFromDirectoryName: $_"
    }
}

Export-ModuleMember -Function Set-DirectoryInReverseOrder, Remove-PrefixFromDirectoryName