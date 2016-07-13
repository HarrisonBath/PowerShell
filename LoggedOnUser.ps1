Import-Module activedirectory
                $PcName = Read-Host -prompt "Please enter the hostname of the machine"
                $colComputers = Get-ADComputer $PcName -Properties description | ForEach-Object {$_.Name} 
                foreach ($strComputer in $colComputers)
                { 
                $description = Get-ADComputer $strComputer -Properties description
                $Username = (Get-WmiObject -ComputerName $strComputer -class Win32_computersystem).username}
                if($username -like "*Rabo*") 
                {Write-Host $strComputer $username " | Description: " $description.description -ForegroundColor Green}
                Else
                {$description = Get-ADComputer $strComputer -Properties description
                Write-Host "Nobody logged in on $StrComputer | Description: " $description.description -ForegroundColor Red} 
             sleep -seconds 5