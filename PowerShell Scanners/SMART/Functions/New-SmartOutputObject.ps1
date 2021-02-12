function New-SmartOutputObject {

    [CmdletBinding()]
    param (
        [Object]$SmartDataJson,
        [String]$DriveType,
        [Byte[]]$IDs
    )
    
    $Output = [Ordered]@{
        "Serial Number"            = [String]$SmartDataJson.serial_number
        "Passed Health Assessment" = [Bool]  $SmartDataJson.smart_status.passed
        # There are at least 2 different IDs that report temperature (190 and 194),
        # so it's better to use the calculated "temperature" property that smartctl provides.
        "Temperature"              = [Int16] $SmartDataJson.temperature.current
    }

    if ( $DriveType -eq "HDD" ) {

        $Output."Rotation Rate" = [UInt64]$SmartDataJson.rotation_rate

    }

    ForEach ( $ID in $IDs ) {

        $Name = Get-SmartAttributeName -ID $ID -Format "Pretty" -DriveType $DriveType
        $Output.$Name = Get-SmartAttributeValue -ID $ID -JsonObject $SmartDataJson

    }

    [PSCustomObject]$Output

}