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

# zsh-autocomplete keeps its helper functions (_autocomplete__unambiguous and
# friends) in Completions/, which only ever get autoloaded by a compinit run that can
# see that directory on fpath. The plugin's own compinit is a no-op once Oh My Zsh has
# run one, so add the directory here and let Oh My Zsh's compinit pick the helpers up.
fpath=("$ZSH/custom/plugins/zsh-autocomplete/Completions" $fpath)

source "$ZSH/oh-my-zsh.sh"

# Order matters. Oh My Zsh's lib/key-bindings.zsh rebinds Tab, Up, Down and ^R, so
# zsh-autocomplete has to load *after* it or those bindings are silently overwritten
# and the plugin is inert. zsh-syntax-highlighting stays last: it wraps every widget
# defined before it, so anything sourced after it goes unhighlighted.
source "$ZSH/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Autocomplete binds Tab to `complete-word`, which inserts the first match and stops;
# cycling only begins once the menu is already open (Down or Alt-Down). Point Tab at
# the menu instead and it behaves like fish: the first Tab opens the list, every Tab
# after that steps to the next entry, because the `menuselect` keymap already maps Tab
# to `menu-complete`. Shift-Tab steps back, there and on the command line.
bindkey '^I' menu-select

# --- history ---

# lib/history.zsh pairs HISTSIZE=50000 with SAVEHIST=10000, so four fifths of the
# in-memory history is dropped on exit. Override after oh-my-zsh.sh has run.
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_ALL_DUPS  # a repeat evicts the older copy, keeping suggestions fresh
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY           # !! expands onto the line instead of running unseen

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

# Atuin owns ^R only. Up arrow is left to zsh-autocomplete, whose inline history menu
# is the closer match to fish; atuin's own up-arrow takes over the whole screen.
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"

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
