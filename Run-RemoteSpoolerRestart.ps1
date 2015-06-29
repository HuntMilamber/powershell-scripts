# @HuntMilamber

$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
if ($myWindowsPrincipal.IsInRole($adminRole))

   {
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated as Administrator)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
   }

else

   {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);
   exit

   }

 

# Run your code that needs to be elevated here ->[
function Run-RemoteSpoolerRestart
{
$shd = "C:\Windows\system32\spool\printers\*.shd"
$spl = "C:\Windows\system32\spool\printers\*.spl"
$MachineName = Read-Host 'Computer to connect to'
New-PSSession -ComputerName $MachineName -Name $MachineName
# Sleep for 5 seconds to allow for WinRM connection
Start-Sleep -s 5
Enter-PSSession -Name $MachineName
Start-Sleep -s 2 # Sleep for an additional 2 seconds
Stop-Service "Spooler"
Remove-Item $shd
Write-Host "$shd deleted!" -Foregroundcolor "Cyan"
Remove-Item $spl
Write-Host "$spl deleted!" -ForegroundColor "Cyan"
Start-Service "Spooler"
Start-Sleep -s 5
Exit
Remove-PSSession -Name $MachineName
}

Run-RemoteSpoolerRestart
# ]<-
