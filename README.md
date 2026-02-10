# Windows 10 Extreme Privacy Control

**Enhanced & Extreme Telemetry Management Tool (BAT)**

---

## 🇬🇧 English

### Overview

**Windows 10 Extreme Privacy Control** is a BAT-based administrative tool designed to significantly reduce or completely block Windows 10 telemetry and data collection **without breaking Windows Update**.

The tool provides:

* Enhanced and Extreme telemetry disabling modes
* Safe restore to default settings
* Full registry backup and restore
* Action logging
* Interactive menu-driven interface

All changes are **local**, **transparent**, and **reversible**.

---

### Features

#### ✅ Enhanced Mode

* Disables core telemetry services
* Sets telemetry level to **0 (Security)**
* Disables CEIP and feedback collection
* Turns off advertising ID and personalization
* Disables known telemetry scheduled tasks

#### 🔥 Extreme Mode

Includes everything from Enhanced Mode **plus**:

* Additional diagnostic services disabled
* Telemetry endpoints blocked via `hosts`
* Outbound firewall rules blocking Microsoft telemetry IP ranges
* App compatibility inventory disabled

> ⚠️ Extreme Mode heavily limits diagnostics, feedback, and data reporting.

#### 🔄 Restore Options

* **Restore Defaults** — re-enables Windows default telemetry behavior
* **Restore from Backup** — restores registry state from saved `.reg` files

#### 🧾 Logging

* All actions are logged to `privacy_tool.log`
* Includes timestamps for auditing and rollback confidence

---

### What This Tool Does NOT Do

* ❌ Does NOT disable Windows Update
* ❌ Does NOT remove Windows components
* ❌ Does NOT install third-party software
* ❌ Does NOT phone home

---

### Files Created

* `RegistryBackup/`

  * `HKLM_Policies.reg`
  * `HKCU_User.reg`
* `privacy_tool.log`

---

### Usage

1. Download or copy `Win10_Privacy_Extreme.bat`
2. Right-click → **Run as Administrator**
3. Choose an option from the menu
4. Reboot after changes

---

### Compatibility

* Windows 10 Home / Pro / Education
* Not recommended for Enterprise environments with enforced GPO

---

### Disclaimer

This tool modifies system services, firewall rules, and registry keys.

Use at your own risk. Always review scripts before execution.

---

## 🇷🇺 Русский

### Обзор

**Windows 10 Extreme Privacy Control** — это BAT-утилита для администраторов, предназначенная для значительного уменьшения или почти полного отключения телеметрии Windows 10 **без поломки Windows Update**.

Инструмент предоставляет:

* Усиленный и экстремальный режимы отключения телеметрии
* Безопасный возврат к настройкам по умолчанию
* Полный бэкап и восстановление реестра
* Логирование всех действий
* Интерактивное меню

Все изменения **локальные**, **прозрачные** и **обратимые**.

---

### Возможности

#### ✅ Enhanced Mode (Усиленный режим)

* Отключение основных телеметрических служб
* Уровень телеметрии **0 (Security)**
* Отключение CEIP и отзывов
* Отключение рекламного идентификатора и персонализации
* Блокировка телеметрических заданий планировщика

#### 🔥 Extreme Mode (Экстремальный режим)

Включает всё из Enhanced Mode **и дополнительно**:

* Отключение расширенных диагностических служб
* Блокировка серверов телеметрии через `hosts`
* Правила брандмауэра для блокировки IP Microsoft Telemetry
* Отключение инвентаризации совместимости приложений

> ⚠️ Extreme Mode практически полностью отключает диагностику и обратную связь.

#### 🔄 Восстановление

* **Restore Defaults** — возврат стандартного поведения Windows
* **Restore from Backup** — восстановление реестра из сохранённых файлов

#### 🧾 Логирование

* Все действия записываются в `privacy_tool.log`
* Логи содержат дату и время для контроля изменений

---

### Чего скрипт НЕ делает

* ❌ Не отключает Windows Update
* ❌ Не удаляет компоненты Windows
* ❌ Не устанавливает сторонний софт
* ❌ Не передаёт данные наружу

---

### Создаваемые файлы

* `RegistryBackup/`

  * `HKLM_Policies.reg`
  * `HKCU_User.reg`
* `privacy_tool.log`

---

### Использование

1. Сохраните `Win10_Privacy_Extreme.bat`
2. Запустите **от имени администратора**
3. Выберите пункт меню
4. После изменений выполните перезагрузку

---

### Совместимость

* Windows 10 Home / Pro / Education
* Не рекомендуется для доменных / корпоративных сред с GPO

---

### Отказ от ответственности

Скрипт изменяет службы, правила брандмауэра и ключи реестра.

Используйте на свой страх и риск. Всегда проверяйте код перед запуском.

---

**Author:** Community Privacy Tool
**License:** Use freely, no warranty
