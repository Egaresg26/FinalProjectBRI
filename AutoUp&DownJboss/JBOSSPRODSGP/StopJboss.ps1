# Load WinApi functions
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class WinApi {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SwitchToThisWindow(IntPtr hWnd, bool fAltTab);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr SendMessage(IntPtr hWnd, UInt32 Msg, IntPtr wParam, IntPtr lParam);
    }
"@

# Run quit.bat as administrator
Start-Process -FilePath E:\Temenos\BSGPROD\tRun.bat -Verb RunAs
Add-Type -AssemblyName System.Windows.Forms

# Wait for quit.bat to complete
Start-Sleep -Seconds 10

# Send username
[System.Windows.Forms.SendKeys]::SendWait("USERNAME{ENTER}")

Start-Sleep -Seconds 3

# Send password
[System.Windows.Forms.SendKeys]::SendWait("PASSWORD{ENTER}")
Start-Sleep -Seconds 3

# Enter SGP branch
[System.Windows.Forms.SendKeys]::SendWait("SGP{ENTER}")
Start-Sleep -Seconds 3

# Stop TSA service
[System.Windows.Forms.SendKeys]::SendWait("TS, I TSM{ENTER}")
Start-Sleep -Seconds 5
[System.Windows.Forms.SendKeys]::SendWait("6{ENTER}")
Start-Sleep -Seconds 3
[System.Windows.Forms.SendKeys]::SendWait("STOP{ENTER}")
Start-Sleep -Seconds 3

# Paste command from clipboard
[System.Windows.Forms.SendKeys]::SendWait("^V{ENTER}")
Start-Sleep -Seconds 3

# Return to main menu
[System.Windows.Forms.SendKeys]::SendWait("^U{ENTER}")
Start-Sleep -Seconds 3
[System.Windows.Forms.SendKeys]::SendWait("^U{ENTER}")
Start-Sleep -Seconds 3

# Wait for CMD window to finish loading
Start-Sleep -Seconds 3

# Stop JBOSS
$windowName = "Administrator:  JBoss BSGPROD"
$windowProcess = Get-Process | Where-Object { $_.MainWindowTitle -eq $windowName }

# Periksa apakah proses jendela ditemukan
if ($windowProcess) {
    $windowHandle = $windowProcess.MainWindowHandle
    if ($windowHandle -ne [IntPtr]::Zero) {
        [WinApi]::SwitchToThisWindow($windowHandle, $true)
    } else {
        Write-Host "Handle jendela kosong atau tidak valid."
    }
} else {
    Write-Host "Proses jendela tidak ditemukan."
}

# Tunggu jendela command prompt untuk diaktifkan
Start-Sleep -Seconds 5

# Kirimkan Ctrl+C untuk menghentikan ping
[System.Windows.Forms.SendKeys]::SendWait("^C")

Start-Sleep -Seconds 45
Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Seconds 2

[System.Windows.Forms.SendKeys]::SendWait("Y{ENTER}")
Start-Sleep -Seconds 3

# Menutup jendela CMD yang sedang berjalan
if ($windowProcess) {
    $windowProcess.CloseMainWindow()
} else {
    Write-Host "Proses jendela tidak ditemukan untuk ditutup."
}

#Buka Jshell.bat 
Start-Process -FilePath E:\Temenos\BSGPROD\jShel.bat -Verb RunAs
Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Seconds 10

Add-Type -AssemblyName System.Windows.Forms
# buka DBTools
[System.Windows.Forms.SendKeys]::SendWait("DBTools{ENTER}")
Start-Sleep -Seconds 10

[System.Windows.Forms.SendKeys]::SendWait("JQL CLEAR-FILE F.TSA.STATUS WITH @ID NOT LIKE ...OLTP... {ENTER}")
Start-Sleep -Seconds 3

[System.Windows.Forms.SendKeys]::SendWait("x{ENTER}")
Start-Sleep -Seconds 3

$windowName = 'Administrator:  "Database Operations"'
$windowProcess = Get-Process | Where-Object { $_.MainWindowTitle -eq $windowName }

# Periksa apakah proses jendela ditemukan
if ($windowProcess) {
    $windowHandle = $windowProcess.MainWindowHandle
    if ($windowHandle -ne [IntPtr]::Zero) {
        [WinApi]::SwitchToThisWindow($windowHandle, $true)
    } else {
        Write-Host "Handle jendela kosong atau tidak valid."
    }
} else {
    Write-Host "Proses jendela tidak ditemukan."
}

if ($windowProcess) {
    $windowProcess.CloseMainWindow()
} else {
    Write-Host "Proses jendela tidak ditemukan untuk ditutup."
}

$windowName = 'Administrator:  tRun BSGPROD - tRun.bat   -cf "tafj.properties" "EX"'
$windowProcess = Get-Process | Where-Object { $_.MainWindowTitle -eq $windowName }

# Periksa apakah proses jendela ditemukan
if ($windowProcess) {
    $windowHandle = $windowProcess.MainWindowHandle
    if ($windowHandle -ne [IntPtr]::Zero) {
        [WinApi]::SwitchToThisWindow($windowHandle, $true)
    } else {
        Write-Host "Handle jendela kosong atau tidak valid."
    }
} else {
    Write-Host "Proses jendela tidak ditemukan."
}

if ($windowProcess) {
    $windowProcess.CloseMainWindow()
} else {
    Write-Host "Proses jendela tidak ditemukan untuk ditutup."
}