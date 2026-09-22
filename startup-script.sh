#!/bin/bash

# Install homebrew
if ! command -v brew &> /dev/null; then
	echo "Installing Homebrew..."
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew is installed. Skipping..."
fi

sudo apt-get update
sudo apt-get install -y build-essential

# Install development packages
packages=(
	derailed/k9s/k9s
	git-lfs
        go
	neovim
	zellij
	zsh
)
echo "Installing homebrew packages..."
brew install -y "${packages[@]}"

# Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed. Skipping..."
fi

# Add zsh default to end of bashrc
# Starts up zsh when ssh'd in
if ! grep -q "# AUTO-START-ZSH" ~/.bashrc 2>/dev/null; then
    cat <<'EOF' >> ~/.bashrc

# AUTO-START-ZSH
if [[ $- == *i* ]] && command -v zsh >/dev/null 2>&1 && [ -z "$ZSH_VERSION" ]; then
    exec zsh
fi
EOF
fi

# Zsh configs
if ! grep -q "# CUSTOM-CONFIGS" ~/.zshrc 2>/dev/null; then
	cat << 'EOF' >> ~/.zshrc

# CUSTOM-CONFIGS
alias ls="ls -al --color=auto"
EOF
fi

# Auto start Zellij
if ! grep -q "# AUTO-START-ZELLIJ" ~/.zshrc 2>/dev/null; then
    cat <<'EOF' >> ~/.zshrc

# AUTO-START-ZELLIJ
if [[ -o interactive ]] \
    && [ -n "$SSH_CONNECTION" ] \
    && command -v zellij >/dev/null 2>&1 \
    && [ -z "$ZELLIJ" ]; then
    zellij
fi
EOF
fi

# Move Neovim configs into the .config folder
if [ ! -d "$HOME/.config/nvim" ]; then
	cp -r nvim $HOME/.config
fi
