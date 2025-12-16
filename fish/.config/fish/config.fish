set -U fish_greeting ""

# File system
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

function cd
    if test (count $argv) -eq 0
        builtin cd ~
        return
    else if test -d "$argv[1]"
        builtin cd $argv
    else
        z $argv && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    end
end

function open
    xdg-open $argv >/dev/null 2>&1 &
end

# Key bindings
bind \cf 'tmux-sessionizer'
# I really don't think I like this
# bind \eh 'tmux-sessionizer -s 0'
# bind \ej 'tmux-sessionizer -s 1'
# bind \ek 'tmux-sessionizer -s 2'
# bind \el 'tmux-sessionizer -s 3'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias d='docker'
alias r='rails'

function n
    if test (count $argv) -eq 0
        nvim .
    else
        nvim $argv
    end
end

# Git
# alias g='git'
# alias gcm='git commit -m'
# alias gcam='git commit -a -m'
# alias gcad='git commit -a --amend'

# Env
fish_add_path ~/.local/bin

# Extras
starship init fish | source

if [ -f ~/work/unxwares/config/shell.fish ]
    source ~/work/unxwares/config/shell.fish
end
