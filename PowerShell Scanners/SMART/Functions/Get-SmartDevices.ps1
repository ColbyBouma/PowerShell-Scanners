function Get-SmartDevices {

    param (
        [String]$DriveType
    )

    $TypeTable = @{
        "HDD"  = "ATA"
        "SSD"  = "ATA"
        "NVMe" = "NVMe"
    }
    
    $Devices = (smartctl -j --scan | ConvertFrom-Json).Devices

    if ( $DriveType ) {

        ( $Devices | Where-Object Type -eq $TypeTable.$DriveType).Name

    } else {

        $Devices.Name

    }

}