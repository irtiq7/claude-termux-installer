#!/data/data/com.termux/files/usr/bin/bash
set -e
clear
echo "=========================================="
echo "   Claude Code Termux Installer Script    "
echo "=========================================="
echo ""
echo "Choose installation method:"
echo "  1) Pure JS Fallback  - Fastest, runs version 2.1.112 (last JS-only build)"
echo "  2) PRoot Ubuntu      - Supports the LATEST native claude-code versions"
echo ""
read -p "Enter choice [1-2]: " choice

echo ""
echo "[*] Updating packages..."
pkg update -y && pkg upgrade -y

if [ "$choice" -eq 1 ]; then
    echo "[*] Installing dependencies..."
    pkg install nodejs git ripgrep openssh -y

    echo "[*] Installing claude-code@2.1.112 (pure JS build)..."
    npm uninstall -g @anthropic-ai/claude-code 2>/dev/null || true
    npm install -g @anthropic-ai/claude-code@2.1.112

    echo ""
    echo "=========================================="
    echo "  Installation complete!"
    echo "  Run: claude"
    echo "=========================================="

elif [ "$choice" -eq 2 ]; then
    echo "[*] Installing proot-distro and git..."
    pkg install proot-distro git -y

    echo "[*] Installing Ubuntu via proot-distro (this may take a while)..."
    proot-distro install ubuntu 2>/dev/null || true

    echo "[*] Writing Ubuntu setup script..."
    cat << 'INNER' > "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/root/setup.sh"
#!/bin/bash
set -e
apt update && apt upgrade -y
apt install -y curl git ripgrep
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt install -y nodejs
npm install -g @anthropic-ai/claude-code
echo "Claude Code installed inside Ubuntu proot."
INNER

    echo "[*] Running setup inside Ubuntu proot..."
    proot-distro login ubuntu -- bash /root/setup.sh

    echo "[*] Creating claude-ubuntu launcher..."
    cat << 'INNER' > "$PREFIX/bin/claude-ubuntu"
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login ubuntu -- bash -c "cd /root && claude $*"
INNER
    chmod +x "$PREFIX/bin/claude-ubuntu"

    echo ""
    echo "=========================================="
    echo "  Installation complete!"
    echo "  Run: claude-ubuntu"
    echo "=========================================="

else
    echo "Invalid choice. Please run the script again and enter 1 or 2."
    exit 1
fi
