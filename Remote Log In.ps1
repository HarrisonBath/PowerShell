#LondonDealingRoomSupport
        # File Name      : DRSMenu.ps1
        # Author         : Harrison Bath

Function Show-Menu {

Param(
[Parameter(Position=0,Mandatory=$True,HelpMessage="Enter your menu text")]
[ValidateNotNullOrEmpty()]
[string]$Menu,
[Parameter(Position=1)]
[ValidateNotNullOrEmpty()]
[string]$Title="Menu",
[switch]$ClearScreen
)

if ($ClearScreen) {Clear-Host}

#build the menu prompt
$menuPrompt=$title
#add a return
$menuprompt+="`n"
#add an underline
$menuprompt+="-"*$title.Length
$menuprompt+="`n"
#add the menu
$menuPrompt+=$menu


Read-Host -Prompt $menuprompt

} #end function
#Enter the menu below...

$menu=@"

    1. Enable Remote Desktop

    ============================================

     Q. Quit

Select a task by number or Q to exit
"@

#Looping and running menu until user quits

Do{
        #use a Switch construct to take action depending on what menu choice is selected.
        
    Switch (Show-Menu $menu "Harrison's Powershell Scripts" -clear) {
    
        "1" {$ComputerName = Read-Host -prompt "Enable Remote Desktop on" 

                Write-Host "Enabling Remote Desktop on $Computername..."

                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName) 
                $regkey = $reg.OpenSubKey("SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services",$true)
                $regkey.SetValue('fDenyTSConnections','0','DWord')  
		
                Write-Host "Remote Desktop is enabled on machine: $ComputerName" -ForegroundColor Green
	            start-process "C:\Windows\System32\mstsc.exe" -argumentlist "/v:$Computername /f"
                sleep -seconds 5
                 }


        "Q" {Write-Host "Goodbye" -ForegroundColor Green
                Return
                }

                    Default {Write-Warning "Invalid Choice. Try again."
                    sleep -seconds 2
                    }

         } #switch
         } While ($True)