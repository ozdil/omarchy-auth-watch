# 🚨 Auth Watch • Omarchy Authentication & Failed Login Auditor

> **System authentication and failed login attempt auditor plugin for Omarchy 4.0.2+.**

Author: **Ozan Özdil (ozdil)**  
License: **MIT**

---

## ✨ Features

- 🔐 **Journal Authentication Audit:** Inspects recent PAM, sudo, and authentication failure records from `systemd-journald`.
- 🔒 **Fail-Closed Reporting:** Transitions to explicit `UNKNOWN` state on journal access restrictions or timeouts.
- 🛡️ **ANSI Terminal Sanitization:** Cleans and minimizes log outputs before rendering.
- ⏱️ **Zero Hardcoded Paths:** Fully dynamic plugin-relative execution.

---

## 📋 Requirements

- `systemd` (provides `journalctl`)
- `python3` (>= 3.10)

---

## 🚀 Installation & Removal

### Installation
```bash
git clone https://github.com/ozdil/omarchy-auth-watch.git ~/.config/omarchy/plugins/auth-watch
chmod +x ~/.config/omarchy/plugins/auth-watch/auth-*
```

Add to `~/.config/omarchy/shell.json`:
```json
{
  "id": "auth-watch",
  "exec": "$HOME/.config/omarchy/plugins/auth-watch/auth-status",
  "interval": 15,
  "onClick": "omarchy-launch-floating-terminal-with-presentation $HOME/.config/omarchy/plugins/auth-watch/auth-dashboard"
}
```

### Removal
```bash
rm -rf ~/.config/omarchy/plugins/auth-watch
# Remove the "auth-watch" entry from ~/.config/omarchy/shell.json and run:
omarchy-restart-shell
```
