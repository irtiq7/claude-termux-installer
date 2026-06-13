# CLAUDE-CODE-DROID

## Claude Code on Android via Termux 🤖📱

Run Anthropic's [Claude Code](https://claude.ai/code) CLI directly on any Android device using Termux — no root required.

---

## Summary

This project provides a single installer script that sets up Claude Code on Android through Termux. Two methods are supported depending on whether you want the fastest setup or the latest version:

- **Pure JS Fallback (v2.1.112):** The last Claude Code release with a pure-JavaScript build. Runs directly in Termux's Node.js without needing a Linux container. Fastest to install, works out of the box.
- **PRoot Ubuntu:** Installs a full Ubuntu environment inside Termux via `proot-distro`. Supports the latest native Claude Code releases, which require glibc and native binaries unavailable in Termux's musl-based environment.

Turn your Android phone or tablet into a portable AI coding assistant — useful for on-the-go development, reviewing code, or running Claude Code workflows from anywhere.

---

## 📋 Prerequisites

Before starting, ensure you have the following installed on your Android device:

- **Termux:** Download from [F-Droid](https://f-droid.org/en/packages/com.termux/). **Do not use the Google Play Store version** — it is outdated and will not work correctly.
- **An Anthropic API key or Claude.ai Pro/Max subscription** — required to authenticate Claude Code after installation.

---

## 🚀 Quick Start (One-Liner)

Open Termux and paste this single command:

```bash
pkg install -y git && git clone https://github.com/irtiq7/claude-termux-installer.git ~/claude-termux-installer && cd ~/claude-termux-installer && chmod +x install.sh && ./install.sh
```

---

## 🛠️ Installation Methods

### Option 1 — Pure JS Fallback (Recommended for most users)

Installs `@anthropic-ai/claude-code@2.1.112`, the last version built with a pure-JavaScript fallback that runs natively inside Termux's Node.js.

**Installs:** `nodejs`, `git`, `ripgrep`, `openssh`

**After install, run:**
```bash
claude
```

### Option 2 — PRoot Ubuntu (Latest version)

Sets up a full Ubuntu 22.04 environment inside Termux using `proot-distro`, then installs the latest `@anthropic-ai/claude-code` inside it.

**Installs:** `proot-distro`, then inside Ubuntu: `nodejs` (via NodeSource LTS), `git`, `ripgrep`, `claude-code`

**After install, run:**
```bash
claude-ubuntu
```

> **Note:** The `claude-ubuntu` command is a wrapper script placed at `$PREFIX/bin/claude-ubuntu` that drops you into the Ubuntu proot with Claude Code ready.

---

## 📋 Installation Steps

1. **Install Termux** from [F-Droid](https://f-droid.org/en/packages/com.termux/) (not the Play Store).

2. **Clone this repo and run the installer:**
   ```bash
   pkg install -y git
   git clone https://github.com/YOUR_USERNAME/claude-termux-installer.git ~/claude-termux-installer
   cd ~/claude-termux-installer
   chmod +x install.sh
   ./install.sh
   ```

3. **Choose your method** when prompted (1 or 2).

4. **Authenticate Claude Code** after installation:
   ```bash
   claude
   ```
   Follow the on-screen prompts to log in with your Anthropic account or API key.

---

## 🔧 Usage

| Method | Command to launch |
|--------|------------------|
| Pure JS (v2.1.112) | `claude` |
| PRoot Ubuntu (latest) | `claude-ubuntu` |

Pass arguments as normal:
```bash
claude --help
claude-ubuntu "explain this file" --file main.py
```

---

## ⚠️ Known Limitations

- **Option 1 (Pure JS)** is pinned to v2.1.112. Newer versions require native binaries that won't compile under Termux's Android NDK environment.
- **Option 2 (PRoot)** requires more storage (~1 GB for the Ubuntu rootfs) and has slightly slower startup.
- PRoot does not have access to Android sensors/hardware; it is a pure Linux environment.

---

## 🤝 Credits

Inspired by [OpenClaw-Android](https://github.com/irtiq7/OpenClaw-Android) by [Irtiq7](https://github.com/irtiq7).

Claude Code is a product of [Anthropic](https://anthropic.com).
