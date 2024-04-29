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
Start-Process -FilePath E:\Temenos\BSGPROD\jBossBSPROD.bat -Verb RunAs
Add-Type -AssemblyName System.Windows.Forms

Start-Sleep -Seconds 10
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Seconds 180

Start-Process -FilePath E:\Temenos\BSGPROD\tRun.bat -Verb RunAs
Add-Type -AssemblyName System.Windows.Forms

# Wait for to complete
Start-Sleep -Seconds 10

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

Start-Sleep -Seconds 10
Add-Type -AssemblyName System.Windows.Forms

# Send username
[System.Windows.Forms.SendKeys]::SendWait("username{ENTER}")

Start-Sleep -Seconds 3

# Send password
[System.Windows.Forms.SendKeys]::SendWait("PASSWORD{ENTER}")
Start-Sleep -Seconds 3

# Enter SGP branch
[System.Windows.Forms.SendKeys]::SendWait("SGP{ENTER}")
Start-Sleep -Seconds 3

# Start TSA service
[System.Windows.Forms.SendKeys]::SendWait("TS, I TSM{ENTER}")
Start-Sleep -Seconds 3
[System.Windows.Forms.SendKeys]::SendWait("6{ENTER}")
Start-Sleep -Seconds 3
[System.Windows.Forms.SendKeys]::SendWait("START{ENTER}")
Start-Sleep -Seconds 3

# Paste command from clipboard
[System.Windows.Forms.SendKeys]::SendWait("^V{ENTER}")
Start-Sleep -Seconds 3

# Return to main menu
[System.Windows.Forms.SendKeys]::SendWait("^U{ENTER}")
Start-Sleep -Seconds 3
[System.Windows.Forms.SendKeys]::SendWait("^U{ENTER}")
Start-Sleep -Seconds 3

# Load Selenium module
Import-Module "C:\Users\Administrator\Documents\jbosps\WebDriver.dll"

# Impor modul Selenium WebDriver
#Add-Type -Path "C:\Users\user\Documents\ProjectBRI\ProjectJboss\WebDriver.dll"

# Buat objek Firefox WebDriver
#$driver = New-Object OpenQA.Selenium.Firefox.FirefoxDriver("C:\Users\Administrator\Documents\jbosps\geckodriver.exe")
$driver = New-Object OpenQA.Selenium.Firefox.FirefoxDriver

# Define the keywords
$keywords = "START.TSM"

# Navigate to the URL
$driver.Url = "https://172.0.0.1:8443/index.html"
Start-Sleep -Seconds 5

# Click on the "Execute servlet" link
$driver.FindElementByLinkText("Execute servlet").Click()
Start-Sleep -Seconds 3

# Find the search box and enter the keywords
$searchBox = $driver.FindElementByName("command")
$searchBox.SendKeys($keywords)

# Click on the submit button
$submitButton = $driver.FindElementById("submit")
$submitButton.Click()
Start-Sleep -Seconds 3

$driver.Quit()