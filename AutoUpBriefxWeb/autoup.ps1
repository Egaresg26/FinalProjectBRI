# Tentukan URL halaman web dan path untuk menyimpan log berdasarkan tanggal hari ini
$url = "http://localhost/login.aspx"
$currentDate = Get-Date -Format 'yyyy-MM-dd'
$logPath = "D:\Titip\Log_$currentDate.txt"

try {
    # Lakukan permintaan ke halaman web dengan metode Head
    $response = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 10

    if ($response.StatusCode -eq 200) {
        # Jika halaman web dapat diakses dengan status kode 200, catat dalam log
        $logMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Halaman Web dapat diakses"
		Write-Host "Halaman Web Berhasi Diakses"
    } else {
        # Jika halaman web tidak dapat diakses, restart Website
        $logMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Halaman Web tidak dapat diakses, restart Website "
        Stop-Website -Name "NewTRA"
        Start-Sleep -Seconds 2
        Start-Website -Name "NewTRA"
        $logMessage += "`r`n$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Situs web berhasil direstart"
		Write-Host "Halaman Web Berhasi Gagal Diakses, Restart Web berhasil"
    }
} catch {
    # Tangani kesalahan saat melakukan permintaan ke halaman web
    $logMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Terjadi kesalahan saat mencoba akses halaman"
    Stop-Website -Name "NewTRA"
    Start-Sleep -Seconds 2
    Start-Website -Name "NewTRA"
    $logMessage += "`r`n$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Situs web berhasil direstart"
	Write-Host "Halaman Web Berhasi Gagal Diakses, Restart Web berhasil"
}

# Simpan pesan log ke dalam file log berdasarkan tanggal hari ini
$logMessage | Out-File -FilePath $logPath -Append
