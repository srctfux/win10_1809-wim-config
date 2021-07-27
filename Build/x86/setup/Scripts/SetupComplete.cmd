@echo off

powercfg -h off

reg IMPORT %WINDIR%\Setup\Scripts\Software.reg

sc config AppXSvc start= disabled
sc config AxInstSV start= disabled
sc config BITS start= disabled
sc config CDPUserSvc start= disabled
sc config defragsvc start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config DiagTrack start= disabled
sc config DPS start= disabled
sc config DsmSvc start= disabled
sc config DusmSvc start= disabled
sc config fdPHost start= disabled
sc config FDResPub start= disabled
sc config LanmanServer start= disabled
sc config LanmanWorkstation start= disabled
sc config lfsvc start= disabled
sc config LicenseManager start= disabled
sc config lmhosts start= disabled
sc config MessagingService start= disabled
sc config NcaSvc start= disabled
sc config NcbService start= disabled
sc config netbios start= disabled
sc config netbt start= disabled
sc config OneSyncSvc start= disabled
sc config p2pimsvc start= disabled
sc config PNRPAutoReg start= disabled
sc config PNRPsvc start= disabled
sc config RetailDemo start= disabled
sc config PushToInstall start= disabled
sc config ShellHWDetection start= disabled
sc config SSDPSRV start= disabled
sc config TabletInputService start= disabled
sc config upnphost start= disabled
sc config UsoSvc start= disabled
sc config WdiServiceHost start= disabled
sc config WdiSystemHost start= disabled
sc config WdNisSvc start= disabled
sc config wercplsupport start= disabled
sc config WerSvc start= disabled
sc config wisvc start= disabled
sc config wlidsvc start= disabled
sc config WMPNetworkSvc start= disabled
sc config WPDBusEnum start= disabled
sc config workfolderssvc start= disabled
sc config WpnService start= disabled
sc config WSearch start= disabled
sc config wuauserv start= disabled
sc config XblAuthManager start= disabled
sc config XblGameSave start= disabled
sc config XboxGipSvc start= disabled
sc config XboxNetApiSvc start= disabled

schtasks /Change /TN "\Microsoft\Windows\AppID\EDP Policy Manager" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\HandleCommand" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\HandleWnsCommand" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\IntegrityCheck" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\LocateCommandUserSession" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceAccountChange" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceSettingChange" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DeviceDirectoryClient\RegisterUserDevice" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Device Information\Device" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Device Setup\Metadata Refresh" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DiskFootprint\Diagnostics" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\DiskFootprint\StorageSense" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\Installation" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Location\Notifications" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Location\WindowsActionDialog" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Maintenance\WinSAT" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\MUI\LPRemove" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\NlaSvc\WiFiTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\SystemRestore\SR" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\TPM\Tpm-HASCertRetr" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\TPM\Tpm-Maintenance" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Backup Scan" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\WCM\WiFiTask" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\Windows Media Sharing\UpdateLibrary" /DISABLE
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /DISABLE
schtasks /Change /TN "\Microsoft\XblGameSave\XblGameSaveTask" /DISABLE

copy /Y %WINDIR%\Setup\Scripts\DisableAPM.exe C:\Windows\System32
schtasks /create /TN DisableAPM /XML %WINDIR%\Setup\Scripts\DisableAPM.xml

rd /s /q  %WINDIR%\Setup\Scripts
