BASHRC_FILE="$HOME/.bashrc"
CONFIG_DIR="$HOME/.config"

BASHRC_ADDITIONS="./bashrc_additions.sh"
STORED_CONFIG=".config"
PACKAGE_LIST="packages.txt"

set -euo pipefail
trap 'echo "Script interrupted."; exit 1' INT

# ---------- CLI ARGS ------------

PKG_MANAGER="auto"
OVERWRITE_STRATEGY="skip"

# Parse command line flag
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --apt) PKG_MANAGER="apt-get" ;;
        --dnf) PKG_MANAGER="dnf" ;;
        --no-install) PKG_MANAGER="no-install" ;;
        --force) OVERWRITE_STRATEGY="force" ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

# ---------- CONFIG FILES ------------

# Create .bashrc if it doesn't exist
if [ ! -f "$BASHRC_FILE" ]; then
    echo ".bashrc not found, creating : $BASHRC_FILE"
    touch "$BASHRC_FILE"
fi

# Append only if the marker string isn't already present
if ! grep -q "meodbr/dotfiles" "$BASHRC_FILE"; then
    {
        echo ""
        cat $BASHRC_ADDITIONS
    } >> "$BASHRC_FILE"
    echo "Updated $BASHRC_FILE"
fi

# Create config dir
if [ ! -d "$CONFIG_DIR" ]; then
    echo "config dir not found, creating : $CONFIG_DIR"
    mkdir $CONFIG_DIR
fi

# Add config files
if [ "$OVERWRITE_STRATEGY" = "force" ]; then
    cp -rvfb $STORED_CONFIG/* $CONFIG_DIR/
    echo "Copied config files to $CONFIG_DIR with force overwrite (backup created)"
else
    echo "Copying config files to $CONFIG_DIR, skipping existing files, use --force to overwrite"
    cp -rnv $STORED_CONFIG/* $CONFIG_DIR/
fi
echo "Copied config files to $CONFIG_DIR"

if [ "$PKG_MANAGER" = "no-install" ]; then
    echo "Exiting before installation as per --no-install flag"
    exit 0
fi

# ---------- PACKAGES INSTALL ----------

# Starship install
curl -sS https://starship.rs/install.sh | sh


# Packages install
if [ ! -f "$PACKAGE_LIST" ]; then
    echo "Package list not found: $PACKAGE_LIST"
    exit 1
fi

# Determine actual command
if [ "$PKG_MANAGER" = "auto" ]; then
    if command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
    elif command -v apt-get &> /dev/null; then
        PKG_MANAGER="apt-get"
    else
        echo "ERROR: Could not detect package manager. use either --dnf or --apt"
        exit 1
    fi
fi
echo "Using package manager: $PKG_MANAGER"

PKG_CMD=""

# Update and set command
if [ "$PKG_MANAGER" = "apt-get" ]; then
    sudo -E apt-get update
    PKG_CMD="sudo -E apt-get install -y"
elif [ "$PKG_MANAGER" = "dnf" ]; then
    sudo -E dnf check-update || true
    PKG_CMD="sudo -E dnf install -y"

    # VSCode install on dnf
    sudo -E rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo -E tee /etc/yum.repos.d/vscode.repo > /dev/null
    sudo -E dnf check-update
    sudo -E dnf install code -y # or code-insiders
fi

# Install packages one by one
while IFS= read -r package; do
    if [ -n "$package" ]; then
        echo "🔧 Installing: $package"
        if $PKG_CMD "$package"; then
            echo "Installed: $package"
        else
            echo "Failed to install: $package"
        fi
    fi
done < "$PACKAGE_LIST"
echo "Script ended, running source ~/.bashrc"
source ~/.bashrc


