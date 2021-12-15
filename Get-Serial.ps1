<#
.SYNOPSIS
    Fetches serial numbers from remote machines given hostnames or OU path.
.DESCRIPTION
    There are two functions avaialble in this module.

    The first, Get-Serial, is intended to fetch the serial number or remote computers. The parameter -ComputerName can be one name, or
    a comma-separated list of names. The object returned contains the computer name and its serial number.

    The second, Get-OUSerials, accepts an Active Directory OU path as input and called Get-Serial for each returned computer.
.NOTES
    Repository: https://github.com/CambridgeComputing/Get-Serial
    Author: Dennis McDonald
.LINK
    https://github.com/CambridgeComputing/Get-Serial
.EXAMPLE
    Get-Serial Server01,Server02,Workstation01
    Get-OUSerials "OU=Servers,DC=contoso,DC=org"
#>

Function Get-Serial {
    Param (
        [array]$ComputerName
    )

    if ($null -eq $ComputerName) {              # if no argument passed...
        if ($null -eq $input){                  # and no arrays piped...
            $ComputerName = "localhost"         # get local serial
        }else{
            # Get piped string and split into parameter array
            [string]$pipedArray = @($input)     
            $ComputerName = $pipedArray.Split(",")
        }
    }

    $ComputersTable = ForEach ($computer in $ComputerName) {
        # Create a test for connectivity here!
        New-Object psobject -Property @{
            Name = $computer
            Serial = (get-ciminstance -classname win32_bios -computername $computer).SerialNumber
        }
    }
    Return $ComputersTable
}

Function Get-OUSerials {
    Param (
        [string]$OUpath
    )
    $computers = Get-ADComputer -Filter * -SearchBase $OUpath
    $computerNames = @($computers | ForEach-Object {$_.Name})
    Get-Serial -ComputerName $computerNames
}