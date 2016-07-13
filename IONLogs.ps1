#LondonDealingRoomSupport
        # File Name      : IONLogs.ps1

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

    1. ION Logs

    ============================================

    Q. Quit

Select a task by number or Q to exit
"@

#Looping and running menu until user quits

Do{
        #use a Switch construct to take action depending on what menu choice is selected.
        
    Switch (Show-Menu $menu "Harrison's Powershell Script" -clear) {
    
        "1"{
            $FindUser = read-host "Enter user ID"
            $ADUser = Get-ADUSer -LDAPFilter "(sAMAccountName=$FindUser)"
            $ErrorActionPreference= "SilentlyContinue"
            if($ADUser -ne $Null)
            {
                $TransferFolder = read-host "Enter Transfer$ folder to copy to"
                $DestinationPath="\\EURV150001\Transfer$\$TransferFolder"
                If(test-path $DestinationPath)
                {
                    if(Get-WriteAccess $DestinationPath)
                    {
                        if(Test-Path "$DestinationPath\$FindUser")
                        { 
                            # Delete previous User folder from Transfer$ if exists
                            remove-item "$DestinationPath\$FindUser" -recurse
                        }

                        # Create User folder on Transfer$ (below destination folder)
                        New-Item "$DestinationPath\$FindUser" -type directory 
 
                        $Computers =  Get-ADComputer  -Filter {(enabled -eq "true") -and (name -like "LOTD*")} | Select-Object -ExpandProperty Name
                        ForEach($Computer in $Computers)
                        {
                            #write-host $Computer
                            $User = $null
                            $User = Get-LoggedOnUser -ComputerName $Computer
                            #write-host $User
                            if($User -ne $Null)
                            {
                                if($User -eq $FindUser)
                                {
                                    write-host "$User is logged in to $Computer" -ForegroundColor Green
                                    sleep -seconds - 3

                                    $SourcePath = "\\$Computer\C$\Program Files\ION Trading\MMI\MMI_IGB_$user\LOGS\"
                                    if(test-path $SourcePath)
                                    {
                                        $LogFiles=Get-ChildItem $SourcePath -Filter *.log 
                        
                                        ForEach($LogFile in $LogFiles)
                                        {
                                            if((New-TimeSpan $LogFile.LastWriteTime).days -le 1)
                                            {
                                            $LogFile.CopyTo("$DestinationPath\$User\$LogFile", $True)
                                            }#write-host "$LogFile ...copied to $SourcePath"
                                        }#End loop through log files
                                        write-host "ION logs copied for user: $User to $DestinationPath\$User"  -ForegroundColor Green
                                        sleep -seconds 3
                                        read-host -prompt "Press Enter to continue"

                                   }
                                    else
                                    {
                                        if(test-path "\\$Computer\C$\Program Files\ION Trading\")
                                        {
                                            write-host "$SourcePath not found"
                                            sleep -Seconds 3
                                        }
                                        else
                                        {
                                            write-host "Error: ION not installed on $Computer"
                                            sleep -Seconds 3
                                        }
                                    }#End User logged into $Computer
                                    break
                                } # end User=FindUser
                            }#End if $user is null
                        }#End Foreach$Computer
                        if($User -eq $Null)
                        {
                            write-host "User: $FindUser not logged in (LOTD, LOND or CDCD)"
                            sleep -Seconds 3
                        }
                    }
                    else
                    {
                        write-host "You do not have write access to $DestinationPath"  
                        sleep -Seconds 3
                    }
                }
                else
                {
                    write host "Destination path: $DestinationPath not found"  
                    sleep -Seconds 3
                }#End DestinationPath OK
            }
            else
            {
                write-host "User: $FindUser not in AD"
                sleep -Seconds 3
            }#End ADUser Null
        }
                
        "Q" {Write-Host "Goodbye" -ForegroundColor Green
                Return
                }

                    Default {Write-Warning "Invalid Choice. Try again."
                    sleep -seconds 2
                    }

         } #switch
         } While ($True)