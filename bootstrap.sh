DOTFILES_DIR="$HOME/dotfiles-ubuntu-minimal"
PACKER_NVIM_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
STOW_PACKAGES_PATH=$DOTFILES_DIR/packages

# =============================
# Install packages
# =============================
sudo apt update
sudo apt install -y $(cat packages.txt)

curl -fsSL https://tailscale.com/install.sh | sh

# =============================
# Link configs
# =============================
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

echo "Linking configs..."
stow --ignore=DS_Store -v -d $STOW_PACKAGES_PATH -t ~ $(ls $STOW_PACKAGES_PATH)

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
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# =============================
# Install runtimes
# =============================
if command -v mise &> /dev/null; then
    echo "Setting up mise tools..."

    # Activate mise to update PATH
    eval "$(mise activate zsh)"

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
pip install pynvim
