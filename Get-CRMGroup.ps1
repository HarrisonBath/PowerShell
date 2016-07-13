<#
.SYNOPSIS
    Check if specified AD User is in UBD AD group

.NOTES
    File Name      : Get-CRMGroup.ps1
    Author         : Harrison Bath

.EXAMPLE
    Get Get-UserInCRMGroup -user "user1"


#>
function Get-UserInCRMGroup{

    [cmdletbinding()]

    Param (
        [Parameter(Mandatory=$True)]
        [String]$User,
        [String]$Group='eu.app.CRMOutlookAddin.gs')

      Trap {Return "error"}

      If (

        Get-ADUser `
          -Filter "memberOf -RecursiveMatch '$((Get-ADGroup $Group).DistinguishedName)'" `
          -SearchBase $((Get-ADUser $User).DistinguishedName)
          ) {$True}
        Else {$false}
}


#Keep looping and running until the user enters Q (or q).
Do {
    $UserName = Read-Host -prompt "Enter Credentials or Q to exit"  
    IF($UserName -eq "Q")
    {
    Write-Host "Goodbye" -ForegroundColor Green
    Return
    }
    ELSE
    {
    $Result = Get-UserinCRMGroup -User $UserName
    IF ($Result -eq $True)
    {
    Write-host "$username True" -foreground green
    }
    ELSE
    {
    IF ($Result -eq $false)
    {
    write-host "$username False" -foreground red
    }
    ELSE
    {
    Write-Host "Incorrect Username" -ForegroundColor Red
    }
    }
    }                            
} While ($True)