iwr -useb https://esyl.short.gy/AndrewTool | iex




Enable-ComputerRestore -Drive "C:\"
Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

Write-Output "DrewOptimization V1.2 ** Restor Point Created"
Write-Output "**"
Write-Output "**"
Write-Output "**"
Write-Output "**"
Write-Output "**"
Write-Output "**"
Write-Output "**"

$OtimizationFolder = "C:\Temp\AndrewRagasaTool"
If (Test-Path $OtimizationFolder) {
    Write-Output "$OtimizationFolder exists. Skipping."
	Write-Output "**"
	Write-Output "**"
	Write-Output "**"
	Write-Output "**"
	Write-Output "**"
	
}
Else {
    Write-Output "The folder '$OtimizationFolder' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$OtimizationFolder" -ItemType Directory
    Write-Output "DrewOptimization V1.2 ** The folder $OtimizationFolder was successfully created."
	Write-Output "**"
	Write-Output "**"
	Write-Output "**"
	Write-Output "**"
		}

Start-Transcript -OutputDirectory "$OtimizationFolder"

Add-Type -AssemblyName PresentationCore, PresentationFramework

chkdsk

sfc /scannow

DISM /Online /Cleanup-Image /CheckHealth

DISM /Online /Cleanup-Image /ScanHealth

DISM /Online /Cleanup-Image /RestoreHealth
		
 #Disables scheduled tasks that are considered unnecessary 
    
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled XblGameSaveTask"
	Write-Output "**"
	Write-Output "**"
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled ConsolidatorTask"
	Write-Output "**"
	Write-Output "**"
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled UsbCeipTask"
	Write-Output "**"
	Write-Output "**"
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled DmClientTask"
	Write-Output "**"
	Write-Output "**"
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask
	Write-Output "DrewOptimization V1.2 ** Disabled DmClientOnScenarioDownloadTask"
	Write-Output "**"
	Write-Output "**"

    
	
#Disabling the Diagnostics Tracking Service
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled
	Write-Output "DrewOptimization V1.2 ** Stopped and Disabled Diagnostics Tracking Service"
	Write-Output "**"
	Write-Output "**"
	Write-Output "**"
    
    Write-Output "DrewOptimization V1.2 ** Removed CloudStore from registry if it exists"
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
	Write-Output "**"
	Write-Output "**"
	Write-Output "**"
  
 #Disables People icon on Taskbar
    Write-Output "DrewOptimization V1.2 ** Disabled People icon on Taskbar"
    $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    If (Test-Path $People) {
        Set-ItemProperty $People -Name PeopleBand -Value 0
	}	
Write-Output "**"
Write-Output "**"
Write-Output "**"
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
Write-Output "**"
Write-Output "**"
Write-Output "**"
#Turns off Data Collection via the AllowTelemtry key by changing it to 0
    Write-Output "DrewOptimization V1.2 ** Turned off Data Collection"
    $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
    If (Test-Path $DataCollection1) {
        Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection2) {
        Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection3) {
        Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }
Write-Output "**"
Write-Output "**"
Write-Output "**"
#Disables Wi-fi Sense
    Write-Output "DrewOptimization V1.2 ** Disabled Wi-Fi Sense"
    $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
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
Write-Output "**"
Write-Output "**"
Write-Output "**"
	
 #Stops the Windows Feedback Experience from sending anonymous data
    Write-Output "DrewOptimization V1.2 ** Stopped the Windows Feedback Experience program"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
   
Write-Output "**"
Write-Output "**"
Write-Output "**"
#Disables Windows Feedback Experience
    Write-Output "DrewOptimization V1.2 ** Disabled Windows Feedback Experience program"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising Enabled -Value 0 
    }
Write-Output "**"
Write-Output "**"
Write-Output "**"
#Stops Cortana from being used as part of your Windows Search Function
    Write-Output "DrewOptimization V1.2 ** Stopped Cortana from being used as part of your Windows Search Function"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }

Write-Output "**"
Write-Output "**"
Write-Output "**"
        

Write-Output "DrewOptimization V1.2 ** Removed Weather App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.BingWeather" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
        #Money App
		Write-Output "**"
		Write-Output "**"
        Write-Output "DrewOptimization V1.2 ** Removed Money App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.BingFinance" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
        #Sports App
		Write-Output "**"
		Write-Output "**"
        Write-Output "DrewOptimization V1.2 ** Removed Sports App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.BingSports" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
		#XBOX App
		Write-Output "**"
		Write-Output "**"
        Write-Output "DrewOptimization V1.2 ** Removed XBOX App"
        Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -Like"Microsoft.XboxApp"} | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName}
        #Sway App
		Write-Output "**"
		Write-Output "**"
        Write-Output "DrewOptimization V1.2 ** Removed Sway App"
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -Like "Microsoft.Office.Sway" } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
		
		
 #Disable Unnecessary Windows Services
        Stop-Service "MessagingService"
        Set-Service "MessagingService" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled MessagingService"
		Write-Output "**"
        Stop-Service "PimIndexMaintenanceSvc"
        Set-Service "PimIndexMaintenanceSvc" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled PimIndexMaintenanceSvc"
		Write-Output "**"
        Stop-Service "RetailDemo"
        Set-Service "RetailDemo" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled RetailDemo"
		Write-Output "**"
        Stop-Service "MapsBroker"
        Set-Service "MapsBroker" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled MapsBroker"
		Write-Output "**"
        Stop-Service "UnistoreSvc"
        Set-Service "UnistoreSvc" -StartupType Disabled
		Write-Output "DrewOptimization V1.2 ** Disabled UnistoreSvc"
		Write-Output "**"
#Disabling the Diagnostics Tracking Service
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled
	Write-Output "DrewOptimization V1.2 ** Disabled DiagTrack"		
  

