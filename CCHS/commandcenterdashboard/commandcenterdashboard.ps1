#author=Thomas A. Fabrizio (801210714)
#description=Cycle trhough command center dashboards in edge on PC boot.
#version=1.3 Release Canidate
#changelog= Added Cursor Logic and Logic to make sure edge stays running.

#Define functions

#Loop-Check runs a while loop to make sure edge is still running. If it is, it cycles through the boards. If not, it relaunches edge and the boards.
function Loop-check {
	$Running = Get-Process msedge
	while($null -ne $Running){ 
		$wshell=New-Object -ComObject wscript.shell;
		$wshell.AppActivate('Edge'); # Activate on Edge browser
		Start-Sleep 30; # Interval (in seconds) between switch 
		$wshell.SendKeys('^{PGUP}'); # Ctrl + Page Up keyboard shortcut to switch tab
		$wshell.SendKeys('{F5}'); # F5 to refresh active page
		$Running = Get-Process msedge
	}
	Start-edge
	Loop-check
}

#Start edge runs to Start Edge and load the dashboards on script run, and if edge stops running during loop-check
function Start-edge{
Start-Process microsoft-edge:https://commandcenter.applications.cerner.com/dashboards/81c80a10-3835-420d-b590-884c64e5fbde?tenant_key=5c7467fb-60f9-4172-add4-57667a5dfcfa #newark
Start-Process microsoft-edge:https://commandcenter.applications.cerner.com/dashboards/4b071b93-b485-4f43-ac9b-f3c13822e63e?tenant_key=5c7467fb-60f9-4172-add4-57667a5dfcfa #wilmington
Start-Process microsoft-edge:https://commandcenter.applications.cerner.com/dashboards/8edb96f0-7e16-492a-a2f7-087ba012f8ce?tenant_key=5c7467fb-60f9-4172-add4-57667a5dfcfa #middletown
Start-Sleep 9;
$wshell=New-Object -ComObject wscript.shell;
$wshell.AppActivate('Edge');
$wshell.SendKeys('{F11}');
$Running = Get-Process msedge
}


#Move Cursor to Bottom Right
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | out-null
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null
$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bright = $bounds.Location
$bright.X += $bounds.Width
$bright.Y += $bounds.Height
[System.Windows.Forms.Cursor]::Position = $bright


#First Boot Logic
Start-Sleep 5;
Start-edge
Start-Sleep 10;
Loop-check