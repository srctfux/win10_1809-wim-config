@echo off

sc config netbios start= system
sc config netbt start= system
sc config lmhosts start= auto
sc config LanmanWorkstation start= auto
sc config LanmanServer start= auto

net start netbios
net start netbt
net start lmhosts
net start LanmanWorkstation
net start LanmanServer
