        #File name : ADExport
        #Author : Harrison Bath

#This script exports AD Information for all LO* Machines
#Saves the infomation into a csv file located on the temp of LOND121718

            #This part creates csv file with all LO* Machines in AD
            $Filename = Read-Host -prompt "Enter today's date"
            Get-ADComputer -Filter {(enabled -eq "true") -and (name -like "LO*") } -Properties Description | Select-Object Name, Description | Export-CSV \\LOND121718\C$\TEMP\AD\$Filename.csv -NoTypeInformation -Encoding UTF8
                                                                                                                                                  #this part exports the csv file into my TEMP
                        Write-Host "AD Information has been exported" -ForegroundColor Green
                        Sleep -Seconds 3
                        
