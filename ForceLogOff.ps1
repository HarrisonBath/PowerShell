#LondonDealingRoomSupport
        # File Name      : ForceLogOff.ps1
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

    1. Force Log off

    ============================================

    Q. Quit

Select 1 for the script or Q to exit
"@

#Looping and running menu until user quits

Do{
        #use a Switch construct to take action depending on what menu choice is selected.
        
    Switch (Show-Menu $menu "Harrison's Powershell Script" -clear) {
    
        "1"{$Pcname = Read-host -prompt "Please enter the hostname"
            $description = Get-ADComputer $pcname -Properties description
                    Write-Host "Hostname: $pcname | Description: " $description.description -ForegroundColor Green
            $Verification = Read-Host -Prompt "Please type the following security code: HarrisonBath"
            If ($verification -notmatch "HarrisonBath")
            {Write-host "Incorrect security code" -ForegroundColor Red}
            else
            {
            (Get-WmiObject -Class Win32_operatingsystem -ComputerName $Pcname).win32shutdown(4)
                    
            Write-Host "Everyone will be logged off" -ForegroundColor Green
            }
            
            sleep -Seconds 5
                        
                 }

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