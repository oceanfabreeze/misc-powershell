# Delete all Files in \\.....\...\P30\RRD\TEMP older than 228 day(s)
#author=Thomas A. Fabrizio (TF054451)
#verison=1.2 Release Candidate
#changelog= Added logging output in console window and log out a file to the C: drive
$Path = "\\....\...\P30\RRD\TEMP"
$Daysback = "-228"

$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
Start-Transcript -path C:\rrddelete.log
Write-Verbose -Verbose "Deleting RRD Files:"
Write-Verbose -Verbose "Logs in C:\rrddelete.log:"
Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item -Force -Verbose
