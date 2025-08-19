# ProductivityTools.DirectoryReverseOrder

This PowerShell module provides a convenient way to manage the sort order of directories by prepending a numerical prefix to their names. This is particularly useful for scenarios where you want to display directories in a reverse chronological or custom-defined order in file explorers that sort alphabetically.

The module allows you to:
*   Add a descending numerical prefix (e.g., `003_`, `002_`, `001_`) to all subdirectories within a specified path.
*   Remove previously added numerical prefixes.

```powershell
Import-Module -Path .\ProductivityTools.DirectoryReverseOrder.psd1
```

If executed twice it will add second prefix so we can remove prefix executing:

```
import-module .\ProductivityTools.DirectoryReverseOrder.psd1
Remove-Prefix F:\Prism\PrismPhoto\ -Verbose
```

Leading buffor allows to left some of the ids before the first directory, so new directory won't require rebuilding whole structure
