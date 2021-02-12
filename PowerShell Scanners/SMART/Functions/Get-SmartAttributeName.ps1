function Get-SmartAttributeName {

    [CmdletBinding()]
    param (
        [Byte]  $ID,
        [String]$Format,
        [String]$DriveType
    )

    # I got the raw names from drivedb.h in the bin folder of smartmontools.
    # The "pretty" names came from me.
    $NameTable = @{
        1   = "Raw_Read_Error_Rate", "Raw Read Error Rate"
        2   = "Throughput_Performance", "Throughput Performance"
        3   = "Spin_Up_Time", "Spin Up Time"
        4   = "Start_Stop_Count", "Start Stop Count"
        # As far as I'm aware, Retired_Block_Count and Reallocated_Sector_Ct are equivalent.
        # Please let me know if this is incorrect.
        5   = "Reallocated_Sector_Ct|Retired_Block_Count", "Reallocated Sector Count"
        6   = "Read_Channel_Margin", "Read Channel Margin"
        7   = "Seek_Error_Rate", "Seek Error Rate"
        8   = "Seek_Time_Performance", "Seek Time Performance"
        9   = "Power_On_Hours", "Power On Time"
        10  = "Spin_Retry_Count", "Spin Retry Count"
        11  = "Calibration_Retry_Count", "Calibration Retry Count"
        12  = "Power_Cycle_Count", "Power Cycle Count"
        13  = "Read_Soft_Error_Rate", "Read Soft Error Rate"
        175 = "Program_Fail_Count_Chip", "Program Fail Count Chip"
        176 = "Erase_Fail_Count_Chip", "Erase Fail Count Chip"
        177 = "Wear_Leveling_Count", "Wear Leveling Count"
        178 = "Used_Rsvd_Blk_Cnt_Chip", "Used Reserved Block Count Chip"
        179 = "Used_Rsvd_Blk_Cnt_Tot", "Used Reserved Block Count Total"
        180 = "Unused_Rsvd_Blk_Cnt_Tot", "Unused Reserved Block Count Total"
        181 = "Program_Fail_Cnt_Total", "Program Fail Count Total"
        182 = "Erase_Fail_Count_Total", "Erase Fail Count Total"
        183 = "Runtime_Bad_Block", "Runtime Bad Block"
        184 = "End-to-End_Error", "End-to-End Error / IOEDC"
        187 = "Reported_Uncorrect", "Reported Uncorrectable Errors"
        188 = "Command_Timeout", "Command Timeout"
        189 = "High_Fly_Writes", "High Fly Writes"
        190 = "Airflow_Temperature_Cel", "Airflow Temperature"
        191 = "G-Sense_Error_Rate", "G-Sense Error Rate"
        192 = "Power-Off_Retract_Count", "Power-Off Retract Count"
        193 = "Load_Cycle_Count", "Load Cycle Count"
        194 = "Temperature_Celsius", "Temperature"
        195 = "Hardware_ECC_Recovered", "Hardware ECC Recovered"
        196 = "Reallocated_Event_Count", "Reallocation Event Count"
        197 = "Current_Pending_Sector", "Current Pending Sector Count"
        198 = "Offline_Uncorrectable", "(Offline) Uncorrectable Sector Count"
        199 = "UDMA_CRC_Error_Count", "UDMA CRC Error Count"
        200 = "Multi_Zone_Error_Rate", "Multi-Zone Error Rate"
        201 = "Soft_Read_Error_Rate|Unc_Soft_Read_Err_Rate", "Soft Read Error Rate"
        202 = "Data_Address_Mark_Errs", "Data Address Mark Errors"
        203 = "Run_Out_Cancel", "Run Out Cancel"
        204 = "Soft_ECC_Correction", "Soft ECC Correction"
        205 = "Thermal_Asperity_Rate", "Thermal Asperity Rate"
        206 = "Flying_Height", "Flying Height"
        207 = "Spin_High_Current", "Spin High Current"
        208 = "Spin_Buzz", "Spin Buzz"
        209 = "Offline_Seek_Performnce", "Offline Seek Performance"
        220 = "Disk_Shift", "Disk Shift"
        221 = "G-Sense_Error_Rate", "G-Sense Error Rate 2"
        222 = "Loaded_Hours", "Loaded Hours"
        223 = "Load_Retry_Count", "Load Retry Count"
        224 = "Load_Friction", "Load Friction"
        225 = "Load_Cycle_Count", "Load Cycle Count"
        226 = "Load-in_Time", "Load-in Time"
        227 = "Torq-amp_Count", "Torq-amp Count"
        228 = "Power-off_Retract_Count", "Power-off Retract Count"
        230 = "Head_Amplitude", "Head Amplitude"
        231 = "Temperature_Celsius", "Temperature 2"
        232 = "Available_Reservd_Space", "Available Reserved Space"
        233 = "Media_Wearout_Indicator", "Media Wearout Indicator"
        240 = "Head_Flying_Hours", "Head Flying Hours"
        241 = "Total_LBAs_Written", "Total LBAs Written"
        242 = "Total_LBAs_Read", "Total LBAs Read"
        250 = "Read_Error_Retry_Rate", "Read Error Retry Rate"
        254 = "Free_Fall_Sensor", "Free Fall Sensor"
    }

    $FormatTable = @{
        "Raw"    = 0
        "Pretty" = 1
    }

    # For some reason, hashtable lookups only seem to work with Int32. Every other type I've tried fails.
    $Result = $NameTable.[Int32]$ID

    if ( -not $Result ) {

        Write-Verbose "Could not find ID $ID in the table."
        $Result = "Unknown_Attribute", "Unknown Attribute"

    }

    $Result[$FormatTable.$Format]

}