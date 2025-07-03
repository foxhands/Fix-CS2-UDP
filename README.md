### 🇬🇧 
A PowerShell utility script to fix the common `Failed to bind socket (0x00002747)` error in **Counter-Strike 2**. This error is usually caused by too many ephemeral UDP ports being consumed by background processes, interfering with CS2's ability to communicate with game servers.

---

## 🚀 Features

* Expands the system UDP port range (ephemeral ports)
* Detects processes using an unusually high number of UDP ports
* Allows terminating such processes interactively
* PowerShell-native, portable, and simple

---

## 💻 Requirements

* Windows 10 / 11
* PowerShell 5.1+
* Run as Administrator

---

## 📦 Installation

1. Download the `Fix-CS2-UDP.ps1` file from the repo
2. Right-click → **Run with PowerShell** OR open PowerShell as admin and run:

   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   .\Fix-CS2-UDP.ps1
   ```

---

## 📘 Usage

The script will:

1. Extend UDP dynamic port range: `10000–65535`
2. Scan for processes using excessive UDP ports (e.g., FaceitAC, Steam)
3. Prompt you to terminate any such process manually
4. Suggest restarting CS2

> ✅ Ideal for players facing frequent server connection errors in matchmaking or Faceit.

---

## 🌐 Localized Versions

### 🇺🇦

### Fix-CS2-UDP.ps1

PowerShell-скрипт, який вирішує помилку `Failed to bind socket (0x00002747)` у **Counter-Strike 2**. Зазвичай ця проблема викликана тим, що інші програми відкривають надто багато UDP портів.

---

#### 🔧 Функціонал:

* Розширення діапазону динамічних UDP портів
* Виявлення процесів з великою кількістю відкритих UDP портів
* Можливість завершення таких процесів вручну
* Простий, безпечний і швидкий скрипт для PowerShell

---

#### 📦 Встановлення

1. Завантаж `Fix-CS2-UDP.ps1`
2. Відкрий PowerShell від імені адміністратора:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Fix-CS2-UDP.ps1
```

---

#### 📘 Як користуватись

1. Скрипт збільшує діапазон UDP портів до `10000–65535`
2. Виводить список "підозрілих" процесів
3. Запитує дозвіл на їх завершення
4. Рекомендує перезапуск CS2

> ✅ Ідеально підходить, якщо CS2 часто не підключається до серверів

---

## 🔒 Disclaimer

This script only modifies ephemeral port configuration and terminates user-space processes with your permission. It does not make any permanent or system-critical changes.

---

## 📜 License

MIT License
