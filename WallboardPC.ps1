# File Name      : WallboardPC.ps1
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

    1. Log onto wallboard PC

    ============================================

    Q. Quit

Select 1 for the script or Q to exit
"@

#Looping and running menu until user quits

Do{
        #use a Switch construct to take action depending on what menu choice is selected.
        
    Switch (Show-Menu $menu "Harrison's Powershell Script" -clear) {
    
        "1"{$ComputerName='LOTD122159'
                Write-Host "Enabling Remote Desktop on $Computername..."
                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName) 
                $regkey = $reg.OpenSubKey("SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services",$true)
                $regkey.SetValue('fDenyTSConnections','0','DWord')   
                Write-Host "Enabling Remote Desktop on $Computername...Complete"
                start-process "C:\Windows\System32\mstsc.exe" -argumentlist "/v:$Computername /f"}

        "Q" {
                #Quits Script
                Write-Host "Goodbye" -ForegroundColor Green
                Return
            }

                        Default {Write-Warning "Invalid Choice. Try again."
                        sleep -seconds 2
                                }

         } #switch
         } While ($True)
                