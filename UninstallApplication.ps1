 #LondonDealingRoomSupport
        # File Name      : UninstallApplication.ps1
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

    1. Uninstall application

    ============================================

    Q. Quit

Select 1 for the script or Q to exit
"@

#Looping and running menu until user quits

Do{
        #use a Switch construct to take action depending on what menu choice is selected.
        
    Switch (Show-Menu $menu "Harrison's Powershell Script" -clear) {
    
        "1"{
                #Changes AD Description
                Import-Module activedirectory

                    try{

                            $Computername = Read-Host -Prompt "Enter hostname"

                                $match =Read-Host -Prompt "Enter the full application name that you wish to uninstall" 

                                    Write-Progress "Please wait while it looks for $match on $computername"

                                                $app = Get-WmiObject -Class Win32_Product -ComputerName $computername | Where-Object {$_.Name -match “$match”} $app.Uninstall()

                                                    Write-Host "$match has been uninstalled" -ForegroundColor Green

                        }
                            Catch{
                                    Write-Error "$match is not insatlled on $computer"
                                            Sleep -seconds 3

                                 }

             }

        "Q"    {
                #Quits Script
                Write-Host "Goodbye" -ForegroundColor Green
                Return
               }

                        Default {Write-Warning "Invalid Choice. Try again."
                        sleep -seconds 2
                                }

                                                                    } #switch
   } While ($True) 
