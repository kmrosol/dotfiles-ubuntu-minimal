DOTFILES_DIR="$HOME/dotfiles-ubuntu-minimal"
PACKER_NVIM_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
STOW_PACKAGES_PATH=$DOTFILES_DIR/packages

# =============================
# Clone dotfiles Repository
# =============================
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/kmrosol/dotfiles-ubuntu-minimal.git "$DOTFILES_DIR"
else
    echo "Skipping cloning dotfiles. It already exists."
fi

# =============================
# Install packages
# =============================
sudo apt update
sudo xargs -a packages.txt apt install -y

# =============================
# Install mise
# =============================
sudo apt update -y && sudo apt install -y curl
sudo install -dm 755 /etc/apt/keyrings
curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update -y
sudo apt install -y mise

# =============================
# Link configs
# =============================
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

echo "Linking configs..."
stow --ignore=DS_Store -v -d $STOW_PACKAGES_PATH -t ~ $(ls $STOW_PACKAGES_PATH)

# Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# =============================
# Setup tools
# =============================
echo "Setting up development tools..."

# Install packer.nvim
if [ ! -d $PACKER_NVIM_DIR ]; then
    echo "Installing packer.nvim..."
    git clone https://github.com/wbthomason/packer.nvim \
        $PACKER_NVIM_DIR
else
    echo "packer.nvim is already installed."
fi

# Install zsh prompt
if [ ! -d "$HOME/.zsh/pure" ]; then
    echo "Installing pure prompt..."
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
else
    echo "pure prompt is already installed."
fi

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s $(which zsh)
    echo "Shell changed to zsh. Please log out and log back in for the change to take effect."
else
    echo "Default shell is already zsh."
fi

# Install mise
curl https://mise.run | sh

# =============================
# Install runtimes
# =============================

# Add mise to PATH for current session
export PATH="$HOME/.local/bin/mise:$PATH"

if command -v mise &> /dev/null; then
    echo "Setting up mise tools..."

    # Activate mise to update PATH (detect current shell)
    if [ -n "$BASH_VERSION" ]; then
        eval "$(mise activate bash)"
    elif [ -n "$ZSH_VERSION" ]; then
        eval "$(mise activate zsh)"
    else
        eval "$(mise activate sh)"
    fi

    # Install tools defined in mise.toml or .mise.toml
    if [ -f ~/.config/mise/config.toml ] ; then
        echo "Installing tools from mise configuration..."
        mise install

    else
        echo "No mise configuration found, skipping tool installation."
    fi
else
    echo "mise not available, skipping mise setup."
fi

# Install python provider for neovim
pip install --user pynvim
