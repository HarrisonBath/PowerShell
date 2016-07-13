#LondonDealingRoomSupport
        # File Name      : Set-ADDescription.ps1
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

    1. Change AD Description

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
                
                    $COMPUTERNAME = Read-Host -Prompt "Enter Hostname"
                    $description = Get-ADComputer $Computername -Properties description
                    Write-Host "Hostname: $computername | Description: " $description.description -ForegroundColor Green
                        $description = Read-Host -Prompt "Enter the New AD description"
                        Set-ADComputer $COMPUTERNAME -Description "$description"
                            Write-Host "Please wait while description changes" -ForegroundColor Green
                                Sleep -seconds 5
                    } Catch 
                                    {
                                        #This part will only come into place, if you type an incorrect hostname in the "try" section
                                        Write-Host "$Computername not in AD" -foregroundcolor red
                                            Sleep -seconds 3

                                    }
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
