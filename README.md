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
sudo chmod a+x install.sh
./install.sh [--apt | --dnf]
```

options:
* --apt — Force use of apt-get as package manager.
* --dnf — Force use of dnf as package manager.

If no flag is provided, the script tries to auto-detect the package manager.

## Liens utiles

Intégration rdp pour vm Hyper V (Copy/paste, résolution écran):
https://gist.github.com/HarmfulBreeze/9d013676301d784ce9783a39b0e66a84
