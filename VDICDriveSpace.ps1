     
        $file = "\\LOND121718\C$\TEMP\AD\VDIDiskspace.csv"
        $computers = Get-ADComputer -Filter {(enabled -eq "true") -and (name -like "LONW*") } -Properties Description | Select-Object Name
        $computers.name > $file

            $FreeSpace = @{Expression = {[int]($_.Freespace/1GB)};Name = '| Free Space(GB)'}
            $PercentFree = @{Expression = {[int]($_.Freespace*100/$_.Size)}; Name = '| % of free space'}
            $Size = @{Expression = {[int]($_.Size/1GB)};Name = '| Size(GB)'}
           
                Write-Host "Please wait while file is created" -ForegroundColor Green
                Write-Host "Ignore the error message..." -ForegroundColor Red
                    $VDI = get-content \\LOND121718\C$\TEMP\AD\VDIDiskspace.csv 
                    Get-WmiObject Win32_LogicalDisk -ComputerName $VDI -Filter "Drivetype=3" |`
                    Format-Table -Property PSComputerName,$FreeSpace,$PercentFree,$Size | `
                    Out-File '\\LOND121718\C$\TEMP\AD\VDIDiskspaceOutcome.txt'
                    
                        Invoke-Item \\LOND121718\C$\TEMP\AD\VDIDiskspaceOutcome.txt    
                        
                         
