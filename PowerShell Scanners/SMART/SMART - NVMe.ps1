[CmdletBinding()]
param ()
    
$DriveType = "NVMe"

# Load shared functions.
. .\Functions\Get-SmartData.ps1
. .\Functions\Get-SmartDevices.ps1
. .\Functions\Test-Smartmontools.ps1

# Make sure smartmontools is installed and a new enough version.
Test-Smartmontools

$DriveNames = Get-SmartDevices -DriveType $DriveType
ForEach ( $DriveName in $DriveNames ) {

    $SmartDataJson = Get-SmartData -DriveName $DriveName
    
    [PSCustomObject]@{
        "Serial Number"                        = [String]$SmartDataJson.Serial_Number
        "Passed Health Assessment"             = [Bool]$SmartDataJson.Smart_Status.Passed
    }

}