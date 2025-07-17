Enable-ComputerRestore -Drive "C:\"
Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

Write-Output "DrewOptimization V1.2 ** Restore Point Created"


$OtimizationFolder = "C:\Temp\AndrewRagasaTool"
If (Test-Path $OtimizationFolder) {
    Write-Output "$OtimizationFolder exists. Skipping."

	
}
Else {
    Write-Output "The folder '$OtimizationFolder' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$OtimizationFolder" -ItemType Directory
    Write-Output "DrewOptimization V1.2 ** The folder $OtimizationFolder was successfully created."

		}

Start-Transcript -OutputDirectory "$OtimizationFolder"

Add-Type -AssemblyName PresentationCore, PresentationFramework

		
 #Disables scheduled tasks that are considered unnecessary 
    
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled XblGameSaveTask"
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled ConsolidatorTask"
	
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled UsbCeipTask"
	
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled DmClientTask"
	W
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled DmClientOnScenarioDownloadTask"
	

    
	
#Disabling the Diagnostics Tracking Service
$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled
	Write-Output "DrewOptimization V1.2 ** Stopped and Disabled Diagnostics Tracking Service"
	
}
    
    Write-Output "DrewOptimization V1.2 ** Removed CloudStore from registry if it exists"
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
	
  
 #Disables People icon on Taskbar
    Write-Output "DrewOptimization V1.2 ** Disabled People icon on Taskbar"
    $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    If (Test-Path $People) {
        Set-ItemProperty $People -Name PeopleBand -Value 0
	}	

$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
#Disabling Location Tracking
    Write-Output "DrewOptimization V1.2 **  Disabled Location Tracking"
    $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
    If (!(Test-Path $SensorState)) {
        New-Item $SensorState
    }
    Set-ItemProperty $SensorState SensorPermissionState -Value 0 
    If (!(Test-Path $LocationConfig)) {
        New-Item $LocationConfig
    }
    Set-ItemProperty $LocationConfig Status -Value 0 

}
#Turns off Data Collection via the AllowTelemtry key by changing it to 0
    Write-Output "DrewOptimization V1.2 ** Turned off Data Collection"
    $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
    If (Test-Path $DataCollection1) {
$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
        Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection2) {
        Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection3) {
        Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }

}
#Disables Wi-fi Sense
    Write-Output "DrewOptimization V1.2 ** Disabled Wi-Fi Sense"
    $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
    $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
    $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
    If (!(Test-Path $WifiSense1)) {
        New-Item $WifiSense1
    }
    Set-ItemProperty $WifiSense1  Value -Value 0 
    If (!(Test-Path $WifiSense2)) {
        New-Item $WifiSense2
    }
    Set-ItemProperty $WifiSense2  Value -Value 0 
    Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 

}
	
$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
 #Stops the Windows Feedback Experience from sending anonymous data
    Write-Output "DrewOptimization V1.2 ** Stopped the Windows Feedback Experience program"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"

}
$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
#Disables Windows Feedback Experience
    Write-Output "DrewOptimization V1.2 ** Disabled Windows Feedback Experience program"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising Enabled -Value 0 
    }

}
$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
#Stops Cortana from being used as part of your Windows Search Function
    Write-Output "DrewOptimization V1.2 ** Stopped Cortana from being used as part of your Windows Search Function"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }

}
        

Write-Output "DrewOptimization V1.2 ** Removed Weather App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.BingWeather" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
        #Money App
		
        Write-Output "DrewOptimization V1.2 ** Removed Money App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.BingFinance" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
        #Sports App
		
        Write-Output "DrewOptimization V1.2 ** Removed Sports App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.BingSports" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
		#XBOX App
		
        Write-Output "DrewOptimization V1.2 ** Removed XBOX App"
        Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -Like"Microsoft.XboxApp"} | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName}
        #Sway App
		
        Write-Output "DrewOptimization V1.2 ** Removed Sway App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.Office.Sway" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
		
		
         Stop-Service "MessagingService"
        Set-Service "MessagingService" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled MessagingService"
		
        Stop-Service "PimIndexMaintenanceSvc"
        Set-Service "PimIndexMaintenanceSvc" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled PimIndexMaintenanceSvc"
		
        Stop-Service "RetailDemo"
        Set-Service "RetailDemo" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled RetailDemo"
		
        Stop-Service "MapsBroker"
        Set-Service "MapsBroker" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled MapsBroker"
		
        Stop-Service "UnistoreSvc"
        Set-Service "UnistoreSvc" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled UnistoreSvc"
		
#Disabling the Diagnostics Tracking Service
$dsregStatus = dsregcmd /status
$aadJoined = $false
foreach ($line in $dsregStatus) {
    if ($line -match 'AzureADJoined\s*:\s*YES') {
        $aadJoined = $true
        break
    }
}
$isDomainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
$isManaged = $isDomainJoined -or $aadJoined
Write-Output "DrewOptimization V1.2 ** Domain Joined: $isDomainJoined, AzureAD Joined: $aadJoined"
if ($isManaged) {
    Write-Output "DrewOptimization V1.2 ** Managed device detected — skipping telemetry and privacy optimizations."
} else {
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled
	Write-Output "DrewOptimization V1.2 ** Disabled DiagTrack"		

}

Write-Output "DrewOptimization V1.2 ** Checking Disk"

chkdsk
if ($LASTEXITCODE -ne 0) {
    Write-Output "DrewOptimization V1.2 ** Issues were detected. It is recommended to run 'chkdsk /f' or appropriate repair commands."
}

Write-Output "DrewOptimization V1.2 ** Checking System Files"

sfc /scannow
if ($LASTEXITCODE -ne 0) {
    Write-Output "DrewOptimization V1.2 ** Issues were detected. It is recommended to run 'chkdsk /f' or appropriate repair commands."
}

Write-Output "DrewOptimization V1.2 ** Checking Image Status"

DISM /Online /Cleanup-Image /CheckHealth
if ($LASTEXITCODE -ne 0) {
    Write-Output "DrewOptimization V1.2 ** Issues were detected. It is recommended to run 'chkdsk /f' or appropriate repair commands."
}

Write-Output "DrewOptimization V1.2 ** Scanning Corrupted Files and Images"
DISM /Online /Cleanup-Image /ScanHealth
if ($LASTEXITCODE -ne 0) {
    Write-Output "DrewOptimization V1.2 ** Issues were detected. It is recommended to run 'chkdsk /f' or appropriate repair commands."
}

Write-Output "  "
Write-Output "AndrewRagasa Optimization Tool is Complete - You can close this window "
  

Write-Output "DrewOptimization V1.2 ** Optimization Summary"
if ($isManaged) {
    Write-Output "[✓] Managed device detected — telemetry and privacy tweaks were skipped."
Write-Output "DrewOptimization V1.2 ** Detailed Summary Log"
Write-Output "Disabled Services:"
Write-Output "Set-Service "DiagTrack" -StartupType Disabled"
Write-Output "Write-Output "DrewOptimization V1.2 ** Stopped and Disabled Diagnostics Tracking Service""
Write-Output "Set-Service "MessagingService" -StartupType Disabled"
Write-Output "Write-Output "DrewOptimization V1.2 ** Disabled MessagingService""
Write-Output "Set-Service "PimIndexMaintenanceSvc" -StartupType Disabled"
Write-Output "Set-Service "RetailDemo" -StartupType Disabled"
Write-Output "Set-Service "MapsBroker" -StartupType Disabled"
Write-Output "Set-Service "UnistoreSvc" -StartupType Disabled"
Write-Output "Set-Service "DiagTrack" -StartupType Disabled"
Write-Output "Removed Applications:"
Write-Output "Write-Output "DrewOptimization V1.2 ** Removed Weather App""
Write-Output "Write-Output "DrewOptimization V1.2 ** Removed Money App""
Write-Output "Write-Output "DrewOptimization V1.2 ** Removed Sports App""
Write-Output "Write-Output "DrewOptimization V1.2 ** Removed XBOX App""
Write-Output "Write-Output "DrewOptimization V1.2 ** Removed Sway App""
Write-Output "Registry Changes:"
Write-Output "New-Item -Path "$OtimizationFolder" -ItemType Directory"
Write-Output "Set-ItemProperty $People -Name PeopleBand -Value 0"
Write-Output "New-Item $SensorState"
Write-Output "Set-ItemProperty $SensorState SensorPermissionState -Value 0"
Write-Output "New-Item $LocationConfig"
Write-Output "Set-ItemProperty $LocationConfig Status -Value 0"
Write-Output "Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0"
Write-Output "Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0"
Write-Output "Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0"
Write-Output "New-Item $WifiSense1"
Write-Output "Set-ItemProperty $WifiSense1  Value -Value 0"
Write-Output "New-Item $WifiSense2"
Write-Output "Set-ItemProperty $WifiSense2  Value -Value 0"
Write-Output "Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0"
Write-Output "Set-ItemProperty $Advertising Enabled -Value 0"
Write-Output "Set-ItemProperty $Search AllowCortana -Value 0"
Write-Output "Summary log saved to: C:\\Temp\\AndrewRagasaTool\\OptimizationSummary.log"
} else {
    Write-Output "[✓] Telemetry and privacy optimizations were applied."
}
Write-Output "[✓] Personal system optimizations (e.g., app removals, service tweaks) were applied."
