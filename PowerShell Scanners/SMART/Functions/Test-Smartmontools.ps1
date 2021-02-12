function Test-Smartmontools {
    
    [CmdletBinding()]
    param ()
    
    Try {

        $SmartmontoolsVersionOutput = smartctl -j -V
        
        # Squash the array into a string since -match is kinda weird with arrays.
        if ( [String]$SmartmontoolsVersionOutput -match "UNRECOGNIZED OPTION" ) {
    
            # "throw" has to be outside the Try, otherwise it would catch it.
            $OldVersion = $true
    
        }
    
    } Catch {
    
        throw "smartmontools 7.0 or later must be installed"
    
    }
    
    if ( $OldVersion ) {
    
        throw "smartmontools must be updated to 7.0 or later"
    
    }

    $SmartmontoolsVersion = ($SmartmontoolsVersionOutput | ConvertFrom-Json).smartctl.version -join "."
    Write-Verbose "Found smartmontools version $SmartmontoolsVersion"

}