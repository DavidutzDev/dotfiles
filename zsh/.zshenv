# Loaded for every zsh, interactive or not — keep it to PATH and env only.

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

export PATH="$HOME/.local/bin:$PATH"
