### 🇬🇧 English
# Fix-CS2-UDP.ps1

A PowerShell utility script to fix the common `Failed to bind socket (0x00002747)` error in **Counter-Strike 2**. This error is usually caused by too many ephemeral UDP ports being consumed by background processes, interfering with CS2's ability to communicate with game servers.

---

## 🚀 Features

* Expands the system UDP port range (ephemeral ports)
* Detects processes using an unusually high number of UDP ports
* Allows terminating such processes interactively
* Language selection (English / Ukrainian / Russian)
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

1. Prompt you to select a language: `en`, `uk`, or `ru`
2. Extend UDP dynamic port range: `10000–65535`
3. Scan for processes using excessive UDP ports (e.g., FaceitAC, Steam)
4. Prompt you to terminate any such process manually
5. Suggest restarting CS2

> ✅ Ideal for players facing frequent server connection errors in matchmaking or Faceit.

---

### 🇺🇦 Українською

PowerShell-скрипт, який вирішує помилку `Failed to bind socket (0x00002747)` у **Counter-Strike 2**. Зазвичай ця проблема викликана тим, що інші програми відкривають надто багато UDP портів.

#### 🔧 Функціонал:

* Розширення діапазону динамічних UDP портів
* Виявлення процесів з великою кількістю відкритих UDP портів
* Можливість завершення таких процесів вручну
* Вибір мови інтерфейсу

#### 📦 Встановлення

1. Завантаж `Fix-CS2-UDP.ps1`
2. Відкрий PowerShell від імені адміністратора:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Fix-CS2-UDP.ps1
```

#### 📘 Як користуватись

1. Обери мову: `en`, `uk` або `ru`
2. Скрипт збільшить діапазон UDP портів до `10000–65535`
3. Виведе список "підозрілих" процесів
4. Запропонує завершити їх
5. Рекомендує перезапуск CS2

---

### 🇷🇺 Русский

PowerShell-скрипт для устранения ошибки `Failed to bind socket (0x00002747)` в **Counter-Strike 2**. Обычно она возникает из-за того, что фоновые процессы занимают слишком много ephemeral UDP-портов.

#### 🔧 Возможности:

* Расширение диапазона UDP портов
* Поиск процессов с подозрительно большим числом портов
* Возможность завершения таких процессов вручную
* Выбор языка интерфейса (английский / украинский / русский)

#### 📦 Установка

1. Скачай `Fix-CS2-UDP.ps1`
2. Запусти PowerShell от имени администратора:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Fix-CS2-UDP.ps1
```

#### 📘 Как использовать

1. Выбор языка: `en`, `uk` или `ru`
2. Скрипт расширит диапазон UDP портов до `10000–65535`
3. Найдёт процессы, которые используют слишком много портов
4. Предложит завершить их
5. Посоветует перезапустить CS2

---

## 🔒 Disclaimer

This script only modifies ephemeral port configuration and terminates user-space processes with your permission. It does not make any permanent or system-critical changes.

---

## 📜 License

MIT License
