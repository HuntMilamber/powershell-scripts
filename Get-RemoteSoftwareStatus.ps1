# 
# Pretty simple script to go out and check every computer you give it in a list for a defined bit of software.
# You can also pipe the output of this script on-screen or onto a file, very flexible.
# Usage: .\Get-SoftwareStatus.ps1 
# -Rich 

Function Get-RemoteSoftwareStatus
{
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipeline, Mandatory, Position = 0)]
        [String] $ComputerName
    )
    
    Process
    {
        $path = '\\{0}\c$\path\to\software' # Change this section to whatever software you need. 

        if ((Test-Connection $ComputerName -Count 1 -quiet))
        {
            if (Test-Path ($path -f $computerName))
            {
                @{$ComputerName = 'Installed'}
            }
            else
            {
                @{$ComputerName = 'Not Installed'}
            }
        }
        else
        {
            @{$ComputerName = 'Offline'}
        }
    }
}

$path = Read-Host 'Text file'
 Get-Content $path | Get-RemoteSoftwareStatus
