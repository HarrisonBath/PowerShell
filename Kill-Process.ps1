#LondonDealingRoomSupport
        # File Name      : Kill-Process.ps1
        # Author         : Harrison Bath


$computername = Read-Host "Enter Hostname"
        Try{
                Get-Process -ComputerName $computername | Select-Object -Property ID, Processname | Sort-Object -Property ID -Descending |  Format-Table -Property ID, Processname -AutoSize
                    $Process = Read-Host "Enter Process you would like to kill"
                        $Verification = Read-Host -Prompt "Are you sure you want to kill $process ? Enter Yes or No"
                            If ($verification -notmatch "Yes")
                                {Write-host "Process has not been killed" -ForegroundColor Red}
                    else
                                    {
                                        (Get-WmiObject Win32_Process -ComputerName $computername | ?{ $_.ProcessName -match "$process" }).Terminate()
                                            Write-Host "$Process has been killed" -ForegroundColor Green
                                                Sleep -seconds 3
                                    }
            }Catch
                                            {
                                                Write-Host "Incorrect Hostname or Incorrect Process" -ForegroundColor Red
                                                    sleep -Seconds 4
                                            }
