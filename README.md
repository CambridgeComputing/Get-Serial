# Get-Serial
Fetches serial numbers from remote machines given hostnames or OU path.

## Functions
There are two functions avaialble in this module.

The first, Get-Serial, is intended to fetch the serial number or remote computers. The parameter -ComputerName can be one name, or
a comma-separated list of names. The object returned contains the computer name and its serial number.

The second, Get-OUSerials, accepts an Active Directory OU path as input and called Get-Serial for each returned computer.

## Examples
Get serial number for a single computer:

    PS:> Get-Serial Server01

    Name       Serial 
    ----       ------ 
    Server01   HE72K86S


Get serial number for a comma-separated list of computers:

    PS:> Get-Serial Server01,Server02

    Name       Serial 
    ----       ------ 
    Server01   HE72K86S
    Server02   HH6SB261

Get serial number for all computers in an Active Directory OU:

    Get-OUSerials "OU=Servers,DC=contoso,DC=org"

    Name       Serial 
    ----       ------ 
    Server01   HE72K86S
    Server02   HH6SB261

# TODO List
- [ ] Add `Test-Connection` before each connection attempt to reduce waiting time and error output
- [ ] Add parameter to output CSV without having to pipe the putput manually
- [ ] Output all computers' names in OU with a placeholder for serial if unreachable
