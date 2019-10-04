# PowerShell function example script: Calculate batting average
# Author: Guy Thomas
Function Get-BatAvg {
[cmdletbinding()]
Param (
[string]$Name,
[int]$Hits, [int]$AtBats
)
# End of Parameters
 Process {
Clear-Host
"Enter Name Hits AtBats..."
$Avg = [int]($Hits / $AtBats*100)/100
if($Avg -gt 1)
{
Clear-Host
"$Name's cricket average = $Avg : $Hits Runs, $AtBats dismissals"
} # End of If
Else {
Clear-Host
"$Name's baseball average = $Avg : $Hits Hits, $AtBats AtBats"
} # End of Else.
   } # End of Process
}

Get-BatAvg -name Babe -Hits 2873 -AtBats 7530
