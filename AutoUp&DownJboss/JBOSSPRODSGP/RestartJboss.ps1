#StopJboss
Start-Process powershell.exe -ArgumentList "C:\Users\Administrator\Documents\jbosps\StopJboss.ps1" -NoNewWindow
Start-Sleep -Seconds 240
#StartJboss
Start-Process powershell.exe -ArgumentList "C:\Users\Administrator\Documents\jbosps\StartJboss.ps1" -NoNewWindow