function Get-SmartData {

    param (
        $DriveName
    )

    smartctl -j -a $DriveName | ConvertFrom-Json

}