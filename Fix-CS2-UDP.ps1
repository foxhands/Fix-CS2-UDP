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

# ==== LANG SELECTION ====

Clear-Host
Write-Host "╔═══════════════════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                              UDP Port Manager v1.1                                ║" -ForegroundColor Cyan
Write-Host "║                                               CS2 Network Optimizer                               ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "Select language / Выберите язык / Оберіть мову:" -ForegroundColor Yellow
Write-Host "1. English"
Write-Host "2. Русский"
Write-Host "3. Українська"
Write-Host ""

do {
    $langChoice = Read-Host "Enter choice (1-3)"
    if ($langChoice -notin @("1", "2", "3")) {
        Write-Host "Invalid input, please enter 1, 2 or 3." -ForegroundColor Red
    }
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
        "cs2_running" = "CS2 is currently running. Please close it before continuing."
        "cs2_not_running" = "CS2 is not running - good to proceed"
        "performance_mode" = "Applying high-performance network settings..."
        "performance_applied" = "High-performance settings applied"
        "testing_connectivity" = "Testing network connectivity..."
        "connectivity_good" = "Network connectivity test passed"
        "connectivity_issues" = "Network connectivity issues detected"
        "log_created" = "Operation log saved to: {0}"
        "script_completed" = "Script completed successfully."
        "restore_prompt" = "Do you want to restore original UDP port settings from backup? (y/n)"
        "restored" = "Original UDP port settings restored."
        "restore_skipped" = "Restoration skipped."
        "invalid_choice" = "Invalid choice, please try again."
        "exit_message" = "Press any key to exit..."
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
        "cs2_running" = "CS2 в данный момент запущен. Пожалуйста, закройте его перед продолжением."
        "cs2_not_running" = "CS2 не запущен - можно продолжать"
        "performance_mode" = "Применение высокопроизводительных сетевых настроек..."
        "performance_applied" = "Высокопроизводительные настройки применены"
        "testing_connectivity" = "Тестирование сетевого соединения..."
        "connectivity_good" = "Тест сетевого соединения пройден"
        "connectivity_issues" = "Обнаружены проблемы с сетевым соединением"
        "log_created" = "Журнал операций сохранен в: {0}"
        "script_completed" = "Скрипт успешно завершён."
        "restore_prompt" = "Хотите восстановить исходные настройки UDP портов из резервной копии? (y/n)"
        "restored" = "Исходные настройки UDP портов восстановлены."
        "restore_skipped" = "Восстановление пропущено."
        "invalid_choice" = "Неверный выбор, попробуйте снова."
        "exit_message" = "Нажмите любую клавишу для выхода..."
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
        "cs2_running" = "CS2 наразі запущений. Будь ласка, закрийте його перед продовженням."
        "cs2_not_running" = "CS2 не запущений - можна продовжувати"
        "performance_mode" = "Застосування високопродуктивних мережевих налаштувань..."
        "performance_applied" = "Високопродуктивні налаштування застосовано"
        "testing_connectivity" = "Тестування мережевого з'єднання..."
        "connectivity_good" = "Тест мережевого з'єднання пройдено"
        "connectivity_issues" = "Виявлено проблеми з мережевим з'єднанням"
        "log_created" = "Журнал операцій збережено в: {0}"
        "script_completed" = "Скрипт успішно завершено."
        "restore_prompt" = "Бажаєте відновити початкові налаштування UDP портів з резервної копії? (y/n)"
        "restored" = "Початкові налаштування UDP портів відновлено."
        "restore_skipped" = "Відновлення пропущено."
        "invalid_choice" = "Неправильний вибір, спробуйте ще раз."
        "exit_message" = "Натисніть будь-яку клавішу для виходу..."
    }
}

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
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] $Message"
    try {
        Add-Content -Path $logPath -Value $logMessage -ErrorAction Stop
    } catch {
        Write-Host "Failed to write to log file: $_" -ForegroundColor Red
    }
    Write-Host $Message -ForegroundColor $Color
}

# Start logging
Write-Log "UDP Port Manager v1.1 started" "Cyan"
Write-Log "Selected language: $lang" "Cyan"

# Check PowerShell version compatibility
$psVersion = $PSVersionTable.PSVersion
if ($psVersion.Major -lt 5) {
    Write-Log "Warning: PowerShell version 5.1 or higher is recommended. Current version: $psVersion" "Yellow"
}

# Check for running CS2 processes
Write-Log $s["checking_cs2"] "Yellow"
$cs2Processes = Get-Process -Name "cs2" -ErrorAction SilentlyContinue
if ($cs2Processes) {
    Write-Log $s["cs2_running"] "Red"

    # List running CS2 processes
    foreach ($proc in $cs2Processes) {
        Write-Log " - $($proc.ProcessName) (PID: $($proc.Id))" "White"
    }

    # Offer to terminate CS2 processes automatically
    do {
        $terminateCS2 = Read-Host "Terminate all CS2 processes now? (y/n)"
        switch ($terminateCS2.ToLower()) {
            "y" {
                foreach ($proc in $cs2Processes) {
                    try {
                        Stop-Process -Id $proc.Id -Force -ErrorAction Stop
                        Write-Log "Terminated CS2 process PID ${proc.Id}" "Green"
                    } catch {
                        Write-Log "Failed to terminate PID ${proc.Id}: $_" "Red"
                    }
                }
                break
            }
            "n" {
                do {
                    $continue = Read-Host "Continue anyway? (y/n)"
                    if ($continue.ToLower() -eq "y") {
                        break 2
                    } elseif ($continue.ToLower() -eq "n") {
                        Write-Log "Operation cancelled by user" "Yellow"
                        Write-Host $s["exit_message"]
                        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                        exit 0
                    } else {
                        Write-Host $s["invalid_choice"] -ForegroundColor Red
                    }
                } while ($true)
            }
            default {
                Write-Host $s["invalid_choice"] -ForegroundColor Red
            }
        }
    } while ($true)
} else {
    Write-Log $s["cs2_not_running"] "Green"
}

# Show network adapter info
Write-Host ""
Write-Log $s["network_adapter_info"] "Cyan"
try {
    Get-NetAdapter | Format-Table -AutoSize | Out-String | Write-Host
} catch {
    Write-Log "Failed to retrieve network adapter info: $_" "Yellow"
}
Write-Host ""

# Find backup files
$backupFiles = Get-ChildItem -Path $PSScriptRoot -Filter "UDP_Port_Backup_*.txt" | Sort-Object LastWriteTime -Descending

if ($backupFiles -and $backupFiles.Count -gt 0) {
    $backupFile = $backupFiles[0].FullName
    try {
        $content = Get-Content -Path $backupFile -Raw

        $startPort = 0
        $numPorts = 0

        # Define regex patterns for "start port" and "number of ports" in all 3 languages
        $patterns = @{
            "startPort" = @(
                "Start Port\s*:\s*(\d+)",              # English
                "Начальный порт\s*:\s*(\d+)",          # Russian
                "Початковий порт\s*:\s*(\d+)"          # Ukrainian
            )
            "numPorts" = @(
                "Number of Ports\s*:\s*(\d+)",         # English
                "Число портов\s*:\s*(\d+)",             # Russian
                "Кількість портів\s*:\s*(\d+)"          # Ukrainian
            )
        }

        # Helper function to try matching all patterns for a key
        function Find-Match([string[]]$patterns, [string]$text) {
            foreach ($pattern in $patterns) {
                if ($text -match $pattern) {
                    return [int]$matches[1]
                }
            }
            return 0
        }

        $startPort = Find-Match $patterns["startPort"] $content
        $numPorts = Find-Match $patterns["numPorts"] $content

        if ($startPort -gt 0 -and $numPorts -gt 0) {
            Write-Log "Restoring UDP port range start=${startPort}, num=${numPorts}" "Yellow"
            netsh int ipv4 set dynamicport udp start=${startPort} num=${numPorts} | Out-Null
            Write-Log $s["restored"] "Green"
        } else {
            Write-Log "Backup file format not recognized or values missing, cannot restore." "Red"
        }
    } catch {
        Write-Log "Failed to restore from backup: $_" "Red"
    }
} else {
    Write-Log "Резервные копии не найдены, пропускаем восстановление." "Yellow"
}




# Create backup of original UDP ephemeral port settings
Write-Log "Creating backup of original settings..." "Yellow"
try {
    $originalRange = netsh int ipv4 show dynamicport udp
    $backupFileName = "UDP_Port_Backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    $backupPath = Join-Path $PSScriptRoot $backupFileName
    $originalRange | Out-File -FilePath $backupPath -Encoding UTF8 -ErrorAction Stop
    Write-Log ($s["backup_created"] -f $backupPath) "Green"
} catch {
    Write-Log $s["backup_failed"] "Yellow"
}

# Show original UDP ephemeral port range
Write-Log $s["original_range"] "Cyan"
Write-Host $originalRange
Write-Host ""

# Apply high-performance network settings
Write-Log $s["performance_mode"] "Yellow"
try {
    netsh int tcp set global autotuninglevel=normal | Out-Null
    netsh int tcp set global rss=enabled | Out-Null
    netsh int tcp set global chimney=enabled | Out-Null
    netsh int tcp set global netdma=enabled | Out-Null
    Write-Log $s["performance_applied"] "Green"
} catch {
    Write-Log "Failed to apply performance settings: $_" "Yellow"
}

# Flush DNS cache
Write-Log $s["dns_flush"] "Yellow"
try {
    ipconfig /flushdns | Out-Null
    Write-Log $s["dns_flushed"] "Green"
} catch {
    Write-Log "Failed to flush DNS cache: $_" "Yellow"
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
    Write-Log "Failed to check firewall status: $_" "Yellow"
}

# Install extended ephemeral port range
Write-Log $s["installing_ports"] "Yellow"
try {
    # Recommended high port range for UDP ephemeral ports
    $startPort = 10000
    $numPorts = 55535

    netsh int ipv4 set dynamicport udp start=${startPort} num=${numPorts} | Out-Null

    Write-Log $s["new_range"] "Cyan"
    $newRange = netsh int ipv4 show dynamicport udp
    Write-Host $newRange
} catch {
    Write-Log "Failed to set ephemeral port range: $_" "Red"
}

# Collect UDP port usage statistics
Write-Log $s["collecting_stats"] "Yellow"
try {
    $threshold = 50 # Threshold for "heavy" UDP port users

    # Get UDP endpoints grouped by ProcessId
    $udpConnections = Get-NetUDPEndpoint | Group-Object -Property OwningProcess

    $heavyUsers = $udpConnections | Where-Object { $_.Count -gt $threshold }

    if ($heavyUsers.Count -eq 0) {
        Write-Log $s["no_heavy_users"] "Green"
    } else {
        Write-Log ($s["found_heavy_users"] -f $threshold) "Yellow"
        foreach ($group in $heavyUsers) {
            try {
                $pid = $group.Name
                $proc = Get-Process -Id $pid -ErrorAction Stop
                Write-Host "PID: ${pid}  Process: $($proc.ProcessName)  Connections: $($group.Count)" -ForegroundColor Cyan

                # Ask user whether to kill process
                do {
                    $answer = Read-Host ($s["kill_process"] -f "$($proc.ProcessName) (PID ${pid})").ToLower()
                    if ($answer -in @("y", "yes")) {
                        try {
                            Stop-Process -Id ${pid} -Force -ErrorAction Stop
                            Write-Log $s["terminated"] "Green"
                            break
                        } catch {
                            Write-Log "Failed to terminate process PID ${pid}: $_" "Red"
                            break
                        }
                    } elseif ($answer -in @("n", "no")) {
                        Write-Log $s["skipped"] "Yellow"
                        break
                    } else {
                        Write-Host $s["invalid_choice"] -ForegroundColor Red
                    }
                } while ($true)
            } catch {
                Write-Log ($s["process_info_error"] -f $pid) "Yellow"
            }
        }
    }
} catch {
    Write-Log "Failed to collect UDP port usage stats: $_" "Red"
}

# Test network connectivity to google DNS server as quick test
Write-Log $s["testing_connectivity"] "Yellow"
try {
    $pingResult = Test-Connection -ComputerName 8.8.8.8 -Count 3 -Quiet
    if ($pingResult) {
        Write-Log $s["connectivity_good"] "Green"
    } else {
        Write-Log $s["connectivity_issues"] "Red"
    }
} catch {
    Write-Log "Error during connectivity test: $_" "Red"
}

Write-Host ""
Write-Log $s["script_completed"] "Cyan"
Write-Host $s["exit_message"]
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
