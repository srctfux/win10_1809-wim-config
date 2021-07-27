@echo off

set ISOImageLabel=CES_X86FREV_EN-US_DV5

set es-ES_OSLang=0

if not "%es-ES_OSLang%"=="0" (
  set ISOImageLabel=CES_X86FREV_ES-ES_DV5
)

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x86\files\sources\install.wim 1 C:\Build\x86\mount\install
:: 2021-06 Servicing Stack Update
Dism /Image:C:\Build\x86\mount\install /Add-Package /Packagepath:C:\Build\x86\updates\windows10.0-kb5003711-x86_70a7ef9f67506eaeac5ae1747e90220e04e22492.msu
:: Update for removal of Adobe Flash Player
Dism /Image:C:\Build\x86\mount\install /Add-Package /Packagepath:C:\Build\x86\updates\windows10.0-kb4577586-x86_947f151a8bb5a0b0797702e53431c52d56c02c32.msu
:: .NET Framework 4.8
Dism /Image:C:\Build\x86\mount\install /Add-Package /Packagepath:C:\Build\x86\updates\windows10.0-kb4486153-x86_de1c8a0152b298f88ff42dc9114eabfa61d5e957.msu
:: 2021-06 Cumulative Update for .NET Framework 4.8
Dism /Image:C:\Build\x86\mount\install /Add-Package /Packagepath:C:\Build\x86\updates\windows10.0-kb5003255-x86-ndp48_4988553bc3548b6c5bc6fd753c108ad21ad60c12.msu
:: 2021-06 Cumulative Update
Dism /Image:C:\Build\x86\mount\install /Add-Package /Packagepath:C:\Build\x86\updates\windows10.0-kb5003646-x86_bc41b686e8fa772aef30e1c70a4bcf7b329c7a00.msu
C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x86\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x86\files\sources\install.wim 1 C:\Build\x86\mount\install
Dism /Image:C:\Build\x86\mount\install /Disable-Feature /FeatureName:"MSRDC-Infrastructure"
Dism /Image:C:\Build\x86\mount\install /Disable-Feature /FeatureName:"Printing-XPSServices-Features"
Dism /Image:C:\Build\x86\mount\install /Disable-Feature /FeatureName:"SMB1Protocol"
Dism /Image:C:\Build\x86\mount\install /Enable-Feature /FeatureName:"DirectPlay" /All
C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x86\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x86\files\sources\install.wim 1 C:\Build\x86\mount\install
Dism /Image:C:\Build\x86\mount\install /Cleanup-Image /StartComponentCleanup /ResetBase
C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x86\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /mountrw C:\Build\x86\files\sources\install.wim 1 C:\Build\x86\mount\install

:: Post Install
reg load HKEY_USERS\BUILD C:\Build\x86\mount\install\Users\default\ntuser.dat
reg IMPORT C:\Build\x86\setup\Scripts\User.reg
reg unload HKEY_USERS\BUILD
reg load HKLM\BUILD C:\Build\x86\mount\install\Windows\System32\config\SYSTEM
C:\Build\x64\tools\PsExec64.exe -accepteula -nobanner -i -s reg IMPORT C:\Build\x86\setup\Scripts\System.reg
reg unload HKLM\BUILD
XCopy /E C:\Build\x86\setup C:\Build\x86\mount\install\Windows\Setup
copy /Y C:\Build\x86\setup\Scripts\hosts C:\Build\x86\mount\install\Windows\System32\drivers\etc
del C:\Build\x86\mount\install\Windows\Setup\Scripts\hosts
del C:\Build\x86\mount\install\Windows\Setup\Scripts\System.reg
del C:\Build\x86\mount\install\Windows\Setup\Scripts\User.reg

:: Themes
if not "%es-ES_OSLang%"=="0" (
  copy /Y C:\Build\x86\setup\Scripts\Themes\es-ES\*.theme "C:\Build\x86\mount\install\Windows\Resources\Themes"
) else (
  copy /Y C:\Build\x86\setup\Scripts\Themes\en-US\*.theme "C:\Build\x86\mount\install\Windows\Resources\Themes"
)

:: Trash
del /ah C:\Build\x86\mount\install\Users\Public\Desktop\desktop.ini
del /ah C:\Build\x86\mount\install\Users\Public\Downloads\desktop.ini
rd /s /q "C:\Build\x86\mount\install\ProgramData\Microsoft\Windows\Start Menu\Programs\Maintenance"

C:\Build\x64\tools\imagex.exe /unmount /commit C:\Build\x86\mount\install
timeout 2

C:\Build\x64\tools\imagex.exe /COMPRESS maximum /EXPORT "C:\Build\x86\files\sources\install.wim" 1 "C:\Build\x86\files\sources\Enterprise.wim" "Windows 10 Enterprise 2019 LTSC"
C:\Build\x64\tools\imagex.exe /info "C:\Build\x86\files\sources\Enterprise.wim" 1 "Windows 10 Enterprise 2019 LTSC" "Windows 10 Enterprise 2019 LTSC"
del C:\Build\x86\files\sources\install.wim
move C:\Build\x86\files\sources\Enterprise.wim C:\Build\x86\files\sources\install.wim
timeout 2

C:\Build\x64\tools\oscdimg.exe -bootdata:2#p0,e,b"C:\Build\x86\files\boot\etfsboot.com"#pEF,e,b"C:\Build\x86\files\efi\microsoft\boot\efisys.bin" -o -h -m -u2 -udfver102 -l"%ISOImageLabel%" "C:\Build\x86\files" "%ISOImageLabel%.iso"
