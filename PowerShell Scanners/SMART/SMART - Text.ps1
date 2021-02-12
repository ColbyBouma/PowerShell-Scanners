# Returns the raw output of smartctl as 1 string per drive.
# This is only for testing/debugging! Do not use this as your main scanner!
[CmdletBinding()]
param (
    [Switch]$Json
)

# Load shared functions.
. .\Functions\Get-SmartDevices.ps1
. .\Functions\Test-Smartmontools.ps1

# Make sure smartmontools is installed and a new enough version.
Test-Smartmontools

$Parameters = "-a"
if ( $Json ) {

    $Parameters += " -j"

}

$DriveNames = Get-SmartDevices
ForEach ( $DriveName in $DriveNames ) {

    [PSCustomObject]@{
        Output = (smartctl $Parameters $DriveName) -join "`n"
    }

}