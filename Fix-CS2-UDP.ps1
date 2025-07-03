# Запускать от имени администратора!
# Run as Administrator!
# Запускати від імені адміністратора!

# Language selection
Write-Host "Select language / Выберите язык / Оберіть мову:"
Write-Host "1. English"
Write-Host "2. Русский"
Write-Host "3. Українська"
$langChoice = Read-Host "Enter choice (1-3)"

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
        "script_completed" = "Script completed. Recommended to restart CS2."
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
        "script_completed" = "Скрипт завершён. Рекомендуется перезапустить CS2."
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
        "script_completed" = "Скрипт завершено. Рекомендується перезапустити CS2."
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

# Main script execution
Write-Host $s["installing_ports"]
netsh int ipv4 set dynamicport udp start=10000 num=55535 | Out-Null

# Check current range
$range = netsh int ipv4 show dynamicport udp
Write-Host ("`n" + $s["current_range"]) -ForegroundColor Cyan
$range

# Get active UDP connections
Write-Host ("`n" + $s["collecting_stats"])
$udpUsage = Get-NetUDPEndpoint | Group-Object -Property OwningProcess | Sort-Object Count -Descending

# Threshold: how many connections to consider suspiciously large
$threshold = 100
$heavyUsers = $udpUsage | Where-Object { $_.Count -ge $threshold }

if ($heavyUsers.Count -eq 0) {
    Write-Host ("`n" + $s["no_heavy_users"]) -ForegroundColor Green
} else {
    Write-Host ("`n" + ($s["found_heavy_users"] -f $threshold)) -ForegroundColor Yellow

    foreach ($procGroup in $heavyUsers) {
        try {
            $pid = $procGroup.Name
            $proc = Get-Process -Id $pid -ErrorAction Stop
            Write-Host " - $($proc.ProcessName) (PID: $pid) — $($procGroup.Count) $($s["connections_count"])"

            $kill = Read-Host (" → " + ($s["kill_process"] -f $proc.ProcessName))
            if ($kill -eq "y") {
                Stop-Process -Id $pid -Force
                Write-Host ("   " + $s["terminated"])
            } else {
                Write-Host ("   " + $s["skipped"])
            }
        } catch {
            Write-Host (" - " + ($s["process_info_error"] -f $pid))
        }
    }
}

Write-Host ("`n" + $s["script_completed"]) -ForegroundColor Cyan
Pause
