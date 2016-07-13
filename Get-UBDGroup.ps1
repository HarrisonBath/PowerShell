<#
.SYNOPSIS
    Check if specified AD User is in UBD AD group

.NOTES
    File Name      : Get-UserInUBDGroup.psm1
    Author         : Phil Lenthall

.EXAMPLE
    Get Get-UserInUBDGroupNew -user "user1"


#>
function Get-UserInUBDGroup{

    [cmdletbinding()]

    Param (
        [Parameter(Mandatory=$True)]
        [String]$User,
        [String]$Group='ri.app.CtxEUUBD.gs')

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
    $Result = Get-UserinUBDGroup -User $UserName
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