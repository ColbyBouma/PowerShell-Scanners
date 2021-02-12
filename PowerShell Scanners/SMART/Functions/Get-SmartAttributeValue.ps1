function Get-SmartAttributeValue {
    
    param (
        [UInt32]$ID,
        [Object]$JsonObject
    )

    # Find the desired attribute by ID.
    $AttributeObject = $JsonObject.Ata_Smart_Attributes.Table | Where-Object ID -eq $ID

    if ( $AttributeObject ) {
    
        # Handle special cases.
        switch ($ID) {
            # Power on time is weird. It can be reported in at least 5 different formats, so it's easier to just
            # use the calculated value that smartctl outputs higher up in the JSON output.
            9 {
                # Minutes has to be cast to Int32 because New-TimeSpan can't handle $null for some reason :'(
                [Int32]$Hours = $JsonObject.power_on_time.hours
                [Int32]$Minutes = $JsonObject.power_on_time.minutes
                $RawValue = New-TimeSpan -Hours $Hours -Minutes $Minutes
            }
        }

        # No special cases were found.
        if ( -not $RawValue ) {

            # Check for unknown special cases.
            $ExpectedName = Get-SmartAttributeName -ID $ID -Format "Raw"
            if ( $AttributeObject.name -notmatch $ExpectedName ) {

                # If you get this error, please open an Issue on the repo. A special case will need to be added above.
                throw "Expected name for ID $ID`: $ExpectedName, got: $($AttributeObject.name)"

            }

            $RawValue = [UInt64]$AttributeObject.raw.value

        }
        
        $RawValue

    }

}