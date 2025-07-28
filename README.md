# Dotfiles Installer

This repository contains my personal dotfiles and an installation script to set up the environment, configuration files, and required packages automatically.

---

## Installation Script

The installer script performs the following tasks:

- Copies my config files into home `.config` directory.
- Appends my config to home `.bashrc`
- Installs the Starship prompt.
- Installs packages listed in the `package.txt` file.

## Usage

```bash
./install.sh [--apt | --dnf]
```

options:
* --apt — Force use of apt-get as package manager.
* --dnf — Force use of dnf as package manager.

If no flag is provided, the script tries to auto-detect the package manager.