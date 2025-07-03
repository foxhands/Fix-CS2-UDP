# Запускать от имени администратора!
# Run as Administrator!
# Запускати від імені адміністратора!

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "ОШИБКА: Этот скрипт должен быть запущен от имени администратора!" -ForegroundColor Red
    Write-Host "ПОМИЛКА: Цей скрипт повинен бути запущений від імені адміністратора!" -ForegroundColor Red
    Write-Host "`nPress any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Language selection with better formatting
Clear-Host
Write-Host "╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                             🌐 UDP Port Manager v1.0 🌐                                                                      ║" -ForegroundColor Cyan
Write-Host "║                                               CS2 Network Optimizer                                                                         ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Select language / Выберите язык / Оберіть мову:" -ForegroundColor Yellow
Write-Host "1. 🇺🇸 English"
Write-Host "2. 🇷🇺 Русский"
Write-Host "3. 🇺🇦 Українська"
Write-Host ""
do {
    $langChoice = Read-Host "Enter choice (1-3)"
} while ($langChoice -notin @("1", "2", "3"))

# Language strings
$strings = @{
    "en" = @{
        "installing_ports" = "Installing extended ephemeral port range..."
        "current_range" = "Current ephemeral port range:"
        "collecting_stats" = "Collecting statistics on open UDP ports..."
        "no_heavy_users" = "No processes with excessive UDP connections found."
        "found_heavy_users" = "Found processes with more than {0} open UDP connections:"
        "connections_count" = "connections"
        "kill_process" = "Terminate process {0}? (y/n)"
        "terminated" = "Terminated."
        "skipped" = "Skipped."
        "process_info_error" = "[PID {0}] Could not get process information (possibly already terminated)"
        "backup_created" = "Backup of original settings created: {0}"
        "backup_failed" = "Warning: Could not create backup of original settings"
        "original_range" = "Original ephemeral port range:"
        "new_range" = "New ephemeral port range:"
        "firewall_check" = "Checking Windows Firewall status..."
        "firewall_enabled" = "Windows Firewall is enabled - this may affect CS2 connectivity"
        "firewall_disabled" = "Windows Firewall is disabled"
        "network_adapter_info" = "Network adapter information:"
        "dns_flush" = "Flushing DNS cache..."
        "dns_flushed" = "DNS cache flushed successfully"
        "checking_cs2" = "Checking for running CS2 processes..."
        "cs2_running" = "⚠️  CS2 is currently running. Please close it before continuing."
        "cs2_not_running" = "CS2 is not running - good to proceed"
        "performance_mode" = "Applying high-performance network settings..."
        "performance_applied" = "High-performance settings applied"
        "testing_connectivity" = "Testing network connectivity..."
        "connectivity_good" = "Network connectivity test passed"
        "connectivity_issues" = "Network connectivity issues detected"
        "log_created" = "Operation log saved to: {0}"
    }
    "ru" = @{
        "installing_ports" = "Установка расширенного диапазона ephemeral портов..."
        "current_range" = "Текущий диапазон ephemeral портов:"
        "collecting_stats" = "Сбор статистики по открытым UDP портам..."
        "no_heavy_users" = "Нет процессов с чрезмерным количеством UDP-соединений."
        "found_heavy_users" = "Найдены процессы с более чем {0} открытыми UDP-соединениями:"
        "connections_count" = "UDP-соединений"
        "kill_process" = "Завершить процесс {0}? (y/n)"
        "terminated" = "Завершено."
        "skipped" = "Пропущено."
        "process_info_error" = "[PID {0}] Не удалось получить информацию о процессе (возможно, уже завершён)"
        "backup_created" = "Создана резервная копия исходных настроек: {0}"
        "backup_failed" = "Предупреждение: Не удалось создать резервную копию исходных настроек"
        "original_range" = "Исходный диапазон ephemeral портов:"
        "new_range" = "Новый диапазон ephemeral портов:"
        "firewall_check" = "Проверка статуса брандмауэра Windows..."
        "firewall_enabled" = "Брандмауэр Windows включен - это может повлиять на подключение к CS2"
        "firewall_disabled" = "Брандмауэр Windows отключен"
        "network_adapter_info" = "Информация о сетевом адаптере:"
        "dns_flush" = "Очистка кэша DNS..."
        "dns_flushed" = "Кэш DNS успешно очищен"
        "checking_cs2" = "Проверка запущенных процессов CS2..."
        "cs2_running" = "⚠️  CS2 в данный момент запущен. Пожалуйста, закройте его перед продолжением."
        "cs2_not_running" = "CS2 не запущен - можно продолжать"
        "performance_mode" = "Применение высокопроизводительных сетевых настроек..."
        "performance_applied" = "Высокопроизводительные настройки применены"
        "testing_connectivity" = "Тестирование сетевого соединения..."
        "connectivity_good" = "Тест сетевого соединения пройден"
        "connectivity_issues" = "Обнаружены проблемы с сетевым соединением"
        "log_created" = "Журнал операций сохранен в: {0}"
    }
    "ua" = @{
        "installing_ports" = "Встановлення розширеного діапазону ephemeral портів..."
        "current_range" = "Поточний діапазон ephemeral портів:"
        "collecting_stats" = "Збір статистики по відкритим UDP портам..."
        "no_heavy_users" = "Немає процесів з надмірною кількістю UDP-з'єднань."
        "found_heavy_users" = "Знайдено процеси з більш ніж {0} відкритими UDP-з'єднаннями:"
        "connections_count" = "UDP-з'єднань"
        "kill_process" = "Завершити процес {0}? (y/n)"
        "terminated" = "Завершено."
        "skipped" = "Пропущено."
        "process_info_error" = "[PID {0}] Не вдалося отримати інформацію про процес (можливо, вже завершений)"
        "backup_created" = "Створено резервну копію початкових налаштувань: {0}"
        "backup_failed" = "Попередження: Не вдалося створити резервну копію початкових налаштувань"
        "original_range" = "Початковий діапазон ephemeral портів:"
        "new_range" = "Новий діапазон ephemeral портів:"
        "firewall_check" = "Перевірка статусу брандмауера Windows..."
        "firewall_enabled" = "Брандмауер Windows увімкнений - це може вплинути на підключення до CS2"
        "firewall_disabled" = "Брандмауер Windows вимкнений"
        "network_adapter_info" = "Інформація про мережевий адаптер:"
        "dns_flush" = "Очищення кешу DNS..."
        "dns_flushed" = "Кеш DNS успішно очищено"
        "checking_cs2" = "Перевірка запущених процесів CS2..."
        "cs2_running" = "⚠️  CS2 наразі запущений. Будь ласка, закрийте його перед продовженням."
        "cs2_not_running" = "CS2 не запущений - можна продовжувати"
        "performance_mode" = "Застосування високопродуктивних мережевих налаштувань..."
        "performance_applied" = "Високопродуктивні налаштування застосовано"
        "testing_connectivity" = "Тестування мережевого з'єднання..."
        "connectivity_good" = "Тест мережевого з'єднання пройдено"
        "connectivity_issues" = "Виявлено проблеми з мережевим з'єднанням"
        "log_created" = "Журнал операцій збережено в: {0}"
    }
}

# Set language based on choice
switch ($langChoice) {
    "1" { $lang = "en" }
    "2" { $lang = "ru" }
    "3" { $lang = "ua" }
    default { $lang = "en" }
}

$s = $strings[$lang]

# Initialize logging
$logFile = "UDP_Port_Manager_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
$logPath = Join-Path $PSScriptRoot $logFile

function Write-Log {
    param($Message, $Color = "White")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] $Message"
    Add-Content -Path $logPath -Value $logMessage
    Write-Host $Message -ForegroundColor $Color
}

# Start logging
Write-Log "UDP Port Manager v1.0 started" "Cyan"
Write-Log "Selected language: $lang" "Cyan"

# Check for CS2 processes
Write-Log $s["checking_cs2"] "Yellow"
$cs2Processes = Get-Process -Name "cs2" -ErrorAction SilentlyContinue
if ($cs2Processes) {
    Write-Log $s["cs2_running"] "Red"
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        Write-Log "Operation cancelled by user" "Yellow"
        exit 0
    }
} else {
    Write-Log $s["cs2_not_running"] "Green"
}

# Create backup of original settings
Write-Log "Creating backup of original settings..." "Yellow"
try {
    $originalRange = netsh int ipv4 show dynamicport udp
    $backupFile = "UDP_Port_Backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    $backupPath = Join-Path $PSScriptRoot $backupFile
    $originalRange | Out-File -FilePath $backupPath -Encoding UTF8
    Write-Log ($s["backup_created"] -f $backupPath) "Green"
} catch {
    Write-Log $s["backup_failed"] "Yellow"
}

# Show original range
Write-Log $s["original_range"] "Cyan"
$originalRange

# Apply high-performance network settings
Write-Log $s["performance_mode"] "Yellow"
try {
    # Set TCP parameters for better performance
    netsh int tcp set global autotuninglevel=normal | Out-Null
    netsh int tcp set global rss=enabled | Out-Null
    netsh int tcp set global chimney=enabled | Out-Null
    netsh int tcp set global netdma=enabled | Out-Null
    Write-Log $s["performance_applied"] "Green"
} catch {
    Write-Log "Failed to apply performance settings" "Yellow"
}

# Flush DNS cache
Write-Log $s["dns_flush"] "Yellow"
try {
    ipconfig /flushdns | Out-Null
    Write-Log $s["dns_flushed"] "Green"
} catch {
    Write-Log "Failed to flush DNS cache" "Yellow"
}

# Check Windows Firewall status
Write-Log $s["firewall_check"] "Yellow"
try {
    $firewallProfiles = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $true }
    if ($firewallProfiles) {
        Write-Log $s["firewall_enabled"] "Yellow"
    } else {
        Write-Log $s["firewall_disabled"] "Green"
    }
} catch {
    Write-Log "Could not check firewall status" "Yellow"
}

# Main script execution
Write-Log $s["installing_ports"] "Yellow"
netsh int ipv4 set dynamicport udp start=10000 num=55535 | Out-Null

# Check current range
$newRange = netsh int ipv4 show dynamicport udp
Write-Log $s["new_range"] "Cyan"
$newRange

# Test network connectivity
Write-Log $s["testing_connectivity"] "Yellow"
try {
    $testResults = @()
    $testHosts = @("8.8.8.8", "1.1.1.1", "valve.steampowered.com")
    
    foreach ($host in $testHosts) {
        $ping = Test-Connection -ComputerName $host -Count 1 -Quiet
        $testResults += $ping
    }
    
    if ($testResults -contains $true) {
        Write-Log $s["connectivity_good"] "Green"
    } else {
        Write-Log $s["connectivity_issues"] "Red"
    }
} catch {
    Write-Log "Could not test connectivity" "Yellow"
}

# Get active UDP connections
Write-Log $s["collecting_stats"] "Yellow"
$udpUsage = Get-NetUDPEndpoint | Group-Object -Property OwningProcess | Sort-Object Count -Descending

# Threshold: how many connections to consider suspiciously large
$threshold = 100
$heavyUsers = $udpUsage | Where-Object { $_.Count -ge $threshold }

if ($heavyUsers.Count -eq 0) {
    Write-Log $s["no_heavy_users"] "Green"
} else {
    Write-Log ($s["found_heavy_users"] -f $threshold) "Yellow"

    foreach ($procGroup in $heavyUsers) {
        try {
            $pid = $procGroup.Name
            $proc = Get-Process -Id $pid -ErrorAction Stop
            $message = " - $($proc.ProcessName) (PID: $pid) — $($procGroup.Count) $($s["connections_count"])"
            Write-Log $message "White"

            $kill = Read-Host (" → " + ($s["kill_process"] -f $proc.ProcessName))
            if ($kill -eq "y") {
                Stop-Process -Id $pid -Force
                Write-Log ("   " + $s["terminated"]) "Green"
            } else {
                Write-Log ("   " + $s["skipped"]) "Yellow"
            }
        } catch {
            $errorMessage = " - " + ($s["process_info_error"] -f $pid)
            Write-Log $errorMessage "Red"
        }
    }
}

# Final summary
Write-Log "=== OPERATION SUMMARY ===" "Cyan"
Write-Log "UDP Port range: 10000-65535" "Green"
Write-Log "DNS cache cleared" "Green"
Write-Log "Performance settings applied" "Green"
Write-Log ($s["log_created"] -f $logPath) "Cyan"
Write-Log $s["script_completed"] "Cyan"
Pause
