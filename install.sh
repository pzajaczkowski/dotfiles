#!/bin/bash
set -e  

# --- 1. Install dependencies ---
echo "Checking dependencies..."
PACKAGES=(stow zsh curl git micro unzip)
for pkg in "${PACKAGES[@]}"; do
    if ! command -v "$pkg" &> /dev/null; then
        echo "Installing missing package: $pkg"
        sudo pacman -Sy --noconfirm "$pkg"
    fi
done

# --- 2. Stow dotfiles with `--adapt` ---
echo "Stowing dotfiles..."
stow --verbose --target="$HOME" --adopt .

# --- 3. Install Fira Mono Nerd Font ---
FONT_DIR="${HOME}/.local/share/fonts"
mkdir -p "${FONT_DIR}"

echo "Downloading and installing Fira Mono Nerd Font..."
curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraMono.tar.xz" | tar -xJf - -C "${FONT_DIR}"
fc-cache -fv
echo "✅ Fira Mono Nerd Font installed."

# --- 4. Install Oh My Posh ---
if ! command -v oh-my-posh &> /dev/null; then
    echo "Installing Oh My Posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
else
    echo "Oh My Posh is already installed."
fi

# --- 5. Install & Setup Zinit ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    echo "Installing Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
else
    echo "Zinit is already installed."
fi

# --- 6. Set Timezone to Warsaw & Fix Windows Dual Boot Time Issue ---
echo "Setting timezone to Europe/Warsaw..."
sudo timedatectl set-timezone Europe/Warsaw
echo "Setting hardware clock to local time for Windows dual boot..."
sudo timedatectl set-local-rtc 1 --adjust-system-clock

# --- 7. Set Zsh as default shell ---
if [[ "$SHELL" != "/bin/zsh" ]]; then
    echo "Changing default shell to Zsh..."
    chsh -s $(which zsh)
    echo "Please log out and log back in to use Zsh as your default shell."
fi

echo "✅ Dotfiles, Zsh, and additional tools installed successfully!"
