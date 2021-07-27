@echo off

set ISOImageLabel=CES_X64FREV_EN-US_DV5

set es-ES_OSLang=0

if not "%es-ES_OSLang%"=="0" (
  set ISOImageLabel=CES_X64FREV_ES-ES_DV5
)

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x64\files\sources\install.wim 1 C:\Build\x64\mount\install
:: 2021-06 Servicing Stack Update
Dism /Image:C:\Build\x64\mount\install /Add-Package /Packagepath:C:\Build\x64\updates\windows10.0-kb5003711-x64_577dc9cfe2e84d23b193aae2678b12e777fc7e55.msu
:: Update for removal of Adobe Flash Player
Dism /Image:C:\Build\x64\mount\install /Add-Package /Packagepath:C:\Build\x64\updates\windows10.0-kb4577586-x64_d0f434327db9e3308b86591c248c825c03687632.msu
:: .NET Framework 4.8
Dism /Image:C:\Build\x64\mount\install /Add-Package /Packagepath:C:\Build\x64\updates\windows10.0-kb4486153-x64_43ee33b302bfdba470542a128a9ee0b58faa5412.msu
:: 2021-06 Cumulative Update for .NET Framework 4.8
Dism /Image:C:\Build\x64\mount\install /Add-Package /Packagepath:C:\Build\x64\updates\windows10.0-kb5003255-x64-ndp48_87ca4e1f20cc5bf55cea9036fec1fe51ae7a524f.msu
:: 2021-06 Cumulative Update
Dism /Image:C:\Build\x64\mount\install /Add-Package /Packagepath:C:\Build\x64\updates\windows10.0-kb5003646-x64_ef50cfb8e8067dd27c13ae7c4150d20cb346b3bf.msu
C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x64\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x64\files\sources\install.wim 1 C:\Build\x64\mount\install
Dism /Image:C:\Build\x64\mount\install /Disable-Feature /FeatureName:"MSRDC-Infrastructure"
Dism /Image:C:\Build\x64\mount\install /Disable-Feature /FeatureName:"Printing-XPSServices-Features"
Dism /Image:C:\Build\x64\mount\install /Disable-Feature /FeatureName:"SMB1Protocol"
Dism /Image:C:\Build\x64\mount\install /Disable-Feature /FeatureName:"SmbDirect"
Dism /Image:C:\Build\x64\mount\install /Enable-Feature /FeatureName:"DirectPlay" /All
C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x64\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x64\files\sources\install.wim 1 C:\Build\x64\mount\install
Dism /Image:C:\Build\x64\mount\install /Cleanup-Image /StartComponentCleanup /ResetBase
C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x64\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x64\files\sources\install.wim 1 C:\Build\x64\mount\install

:: Post Install
reg load HKEY_USERS\BUILD C:\Build\x64\mount\install\Users\default\ntuser.dat
reg IMPORT C:\Build\x64\setup\Scripts\User.reg
reg unload HKEY_USERS\BUILD
reg load HKLM\BUILD C:\Build\x64\mount\install\Windows\System32\config\SYSTEM
C:\Build\x64\tools\PsExec64.exe -accepteula -nobanner -i -s reg IMPORT C:\Build\x64\setup\Scripts\System.reg
reg unload HKLM\BUILD
XCopy /E C:\Build\x64\setup C:\Build\x64\mount\install\Windows\Setup
copy /Y C:\Build\x64\setup\Scripts\hosts C:\Build\x64\mount\install\Windows\System32\drivers\etc
del C:\Build\x64\mount\install\Windows\Setup\Scripts\hosts
del C:\Build\x64\mount\install\Windows\Setup\Scripts\System.reg
del C:\Build\x64\mount\install\Windows\Setup\Scripts\User.reg

:: Themes
if not "%es-ES_OSLang%"=="0" (
  copy /Y C:\Build\x64\setup\Scripts\Themes\es-ES\*.theme "C:\Build\x64\mount\install\Windows\Resources\Themes"
) else (
  copy /Y C:\Build\x64\setup\Scripts\Themes\en-US\*.theme "C:\Build\x64\mount\install\Windows\Resources\Themes"
)

:: Trash
del /ah C:\Build\x64\mount\install\Users\Public\Desktop\desktop.ini
del /ah C:\Build\x64\mount\install\Users\Public\Downloads\desktop.ini
rd /s /q "C:\Build\x64\mount\install\ProgramData\Microsoft\Windows\Start Menu\Programs\Maintenance"

C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x64\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /COMPRESS maximum /EXPORT "C:\Build\x64\files\sources\install.wim" 1 "C:\Build\x64\files\sources\Enterprise.wim" "Windows 10 Enterprise 2019 LTSC"
C:\Build\x64\tools\imagex.exe /info "C:\Build\x64\files\sources\Enterprise.wim" 1 "Windows 10 Enterprise 2019 LTSC" "Windows 10 Enterprise 2019 LTSC"
del C:\Build\x64\files\sources\install.wim
move C:\Build\x64\files\sources\Enterprise.wim C:\Build\x64\files\sources\install.wim
timeout 2

C:\Build\x64\tools\oscdimg.exe -bootdata:2#p0,e,b"C:\Build\x64\files\boot\etfsboot.com"#pEF,e,b"C:\Build\x64\files\efi\microsoft\boot\efisys.bin" -o -h -m -u2 -udfver102 -l"%ISOImageLabel%" "C:\Build\x64\files" "%ISOImageLabel%.iso"
