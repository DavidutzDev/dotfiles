# Managed in ~/dotfiles/zsh — stow package "zsh".
#
# Oh My Zsh and the three plugins below live in ~/.oh-my-zsh at revisions pinned
# by Odyssey's scripts/zsh-setup.sh. CachyOS's /usr/share/cachyos-zsh-config is
# deliberately not sourced: it points ZSH at /usr/share/oh-my-zsh, loads
# powerlevel10k, and sources its own syntax-highlighting and autosuggestions,
# all of which would collide with the pinned set and with starship.

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

zstyle ':omz:update' mode disabled  # Odyssey pins the installed revision
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  gitfast
  alias-finder
  battery
)

# zsh-autocomplete rebinds completion widgets, so it has to load before Oh My Zsh.
source "$ZSH/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

source "$ZSH/oh-my-zsh.sh"

source "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --- path ---

typeset -U path
path=("$HOME/.local/bin" "$HOME/.spicetify" $path)

export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

# --- environment ---

export MANROFFOPT=-c
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# --- aliases ---

alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                   # show only dotfiles

alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                            # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"       # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'   # List amount of -git packages
alias update='sudo pacman -Syu'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# --- functions ---

backup() {
  cp -- "$1" "$1.bak"
}

# --- integrations ---

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# Don't try to peek and see my naughty secret stuff
for _work_rc in "$HOME/work/unxwares/config/shell.zsh" "$HOME/work/unxwares/config/shell.sh"; do
  [[ -f "$_work_rc" ]] && source "$_work_rc" && break
done
unset _work_rc

# --- prompt ---

eval "$(starship init zsh)"

autoload -Uz add-zle-hook-widget

STARSHIP_TRANSIENT_PROMPT="${PROMPT// prompt / prompt --profile transient }"

transient-prompt() {
  PROMPT="$STARSHIP_TRANSIENT_PROMPT" RPROMPT="" zle .reset-prompt
}

add-zle-hook-widget zle-line-finish transient-prompt

# --- greeting ---

[[ -o interactive ]] && command -v fastfetch >/dev/null && fastfetch
