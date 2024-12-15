
cd $PSScriptRoot
Import-Module ./ProductivityTools.DirectoryReverseOrder.psm1 -Force

Set-DirectoryInReverseOrder -Verbose -Directory \\192.168.0.41\Photo\ -LeadingBuffer 100
#Remove-Prefix -Directory \\192.168.0.41\Photo\ -Verbose
