#LondonDealingRoomSupport
        # File Name      : LoggedOnUser.ps1
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

    1. Logged on User

    ============================================

    Q. Quit

Select 1 for the script or Q to exit
"@

#Looping and running menu until user quits

Do{
        #use a Switch construct to take action depending on what menu choice is selected.
        
    Switch (Show-Menu $menu "Harrison's Powershell Script" -clear) {
    
        "1"{
              Try{  
                Import-Module activedirectory
                $PcName = Read-Host -prompt "Please enter the hostname of the machine"
                $colComputers = Get-ADComputer $PcName -Properties description | ForEach-Object {$_.Name} 
                foreach ($strComputer in $colComputers)
                    {$description = Get-ADComputer $strComputer -Properties description
                $Username = (Get-WmiObject -ComputerName $strComputer -class Win32_computersystem).username
                    }
                        if($username -like "*Rabo*") 
                            
                            {Write-Host $strComputer $username " | Description: " $description.description -ForegroundColor Green}
                        Else
                            {$description = Get-ADComputer $strComputer -Properties description
                             Write-Host "Nobody logged in on $StrComputer | Description: " $description.description -ForegroundColor Red
                            } 
                                sleep -seconds 5

                   }Catch

                                    {#This part will only come into place, if you type an incorrect hostname in the "try" section
                                        Write-Host "$pcname not in AD" -foregroundcolor red
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
