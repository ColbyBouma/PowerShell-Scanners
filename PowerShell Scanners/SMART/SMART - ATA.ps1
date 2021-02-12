[CmdletBinding()]
param (
    [Parameter(Mandatory = "True")]
    [ValidateSet("HDD", "SSD")]
    [String]$DriveType,

    [Parameter(Mandatory = "True")]
    [Byte[]]$IDs,

    [String]$TestFile
)

# Load shared functions.
. .\Functions\Get-SmartAttributeName.ps1
. .\Functions\Get-SmartAttributeValue.ps1
. .\Functions\Get-SmartData.ps1
. .\Functions\Get-SmartDevices.ps1
. .\Functions\New-SmartOutputObject.ps1
. .\Functions\Test-Smartmontools.ps1

# Make sure smartmontools is installed and a new enough version.
Test-Smartmontools

if ( $TestFile ) {

    $SmartDataJson = Get-Content -Path $TestFile | ConvertFrom-Json
    New-SmartOutputObject -SmartDataJson $SmartDataJson -DriveType $DriveType -IDs $IDs

} else {

    $DriveNames = Get-SmartDevices -DriveType $DriveType
    ForEach ( $DriveName in $DriveNames ) {

        $SmartDataJson = Get-SmartData -DriveName $DriveName
        New-SmartOutputObject -SmartDataJson $SmartDataJson -DriveType $DriveType -IDs $IDs

    }

}