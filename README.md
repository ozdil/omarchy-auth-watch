# 🚨 Omarchy Auth Watch Plugin

> **Authentication failure watchdog, sudo intrusion monitor, and SSH brute-force sentinel for Omarchy 4.0.2+.**

Author: **Ozan Özdil (ozdil)**  
License: **MIT**

---

## ✨ Features

- 🔐 **Real-Time PAM & Sudo Audit:** Monitors failed sudo password entries and unauthorized privilege escalation attempts.
- 🌐 **SSH Brute-Force Detection:** Tracks external SSH authentication failures across system logs.
- ⚡ **Zero Overhead:** Streamlined journalctl log aggregation with instantaneous alerts.

---

## 🚀 Installation

```bash
# Clone to Omarchy plugins directory
git clone https://github.com/ozdil/omarchy-auth-watch.git ~/.config/omarchy/plugins/auth-watch
chmod +x ~/.config/omarchy/plugins/auth-watch/auth-*
```
