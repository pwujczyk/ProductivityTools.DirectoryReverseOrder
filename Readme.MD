# Directory Reverse Order

Module allows to reverse order of the directories. It does that by adding the leading number to the name. 

Usage 

```
import-module .\ProductivityTools.DirectoryReverseOrder.psd1

Set-DirectoryInReverseOrder e:\Prism\PrismPhoto\ -Verbose
Set-DirectoryInReverseOrder \\192.168.0.41\Prism\PrismPhoto\ -Verbose
```

Leading buffor allows to left some of the ids before the first directory, so new directory won't require rebuilding whole structure


```
import-module .\ProductivityTools.DirectoryReverseOrder.psd1
Remove-Prefix F:\Prism\PrismPhoto\ -Verbose
Remove-Prefix \\192.168.0.41\Prism\PrismPhoto\ -Verbose

Set-DirectoryInReverseOrder F:\Prism\PrismPhoto\ -Verbose
Set-DirectoryInReverseOrder \\192.168.0.41\Prism\PrismPhoto\ -Verbose
```