
cd $PSScriptRoot
Import-Module ./ProductivityTools.DirectoryReverseOrder.psm1 -Force

#Set-DirectoryInReverseOrder -Verbose -Directory D:\Trash
Remove-Prefix -Directory e:\Prism\PrismPhoto\ -Verbose
