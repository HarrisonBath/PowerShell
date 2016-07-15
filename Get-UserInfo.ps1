#LondonDealingRoomSupport
        # File Name      : Get-UserInfo.ps1
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

    1. User Info

    ============================================

    Q. Quit

Select a task by number or Q to exit
"@

#Looping and running menu until user quits

Do{
        #use a Switch construct to take action depending on what menu choice is selected.
        
    Switch (Show-Menu $menu "Harrison's Powershell Script" -clear) {
    
        "1" { 
                Try{
                    Import-Module activedirectory
                        $user = Read-Host -Prompt "Please enter the users credentials"
                            Get-ADUser $user -Properties * | Select CN, SamAccountName, Title, DisplayName, EmployeeNumber, Department, EmailAddress, telephoneNumber, HomeDirectory, ProfilePath, AccountExpirationDate, LastLogonDate, LockedOut, PasswordExpired, PasswordLastSet > "C:\temp\MIDTUser.txt"
                                Invoke-Item "C:\temp\MIDTUser.txt"  
                                Write-Host "Your user information is now on your screen" -ForegroundColor Green
                    }Catch 
                                            {
                                            #This part will only come into place, if you type an incorrect hostname in the "try" section
                                                Write-Host "$user : Incorrect Log-In ID" -foregroundcolor red
                                                    Sleep -seconds 3
                                            }

             }
                
        "Q"     {Write-Host "Goodbye" -ForegroundColor Green
                Return
                }

                    Default {Write-Warning "Invalid Choice. Try again."
                    sleep -seconds 2
                            }

                                                                    } #switch
   } While ($True)
