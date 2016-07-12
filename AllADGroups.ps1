Import-Module activedirectory
                $user = Read-Host -Prompt "Please enter the users login"
                Get-ADUser $user -Properties * | Select memberof | select -Expand memberof > "C:\temp\MIDTUser.txt"
                Invoke-Item "C:\temp\MIDTUser.txt"  
                Write-Host "Your user information is now on your screen" -ForegroundColor Green