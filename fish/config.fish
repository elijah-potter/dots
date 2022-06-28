# Stop .lesshst from appearing
set -x LESSHISTFILE -

# Set Bartib location
set -x BARTIB_FILE ~/timesheet.bartib

# Add stuff to PATH
set -x PATH $PATH $HOME/.cargo/bin

# Remove blacklisted folders from $HOME/.config/
set blacklist gtk-3.0 dconf nnn mpv
for file in $blacklist
    if test -e $HOME/.config/$file
        rm -r $HOME/.config/$file
    end
end

function fish_greeting
end

set -x vault /mnt/vault/
set -x projects ~/Projects/
set -x EDITOR nvim

alias n="nvim"
alias ls="exa --icons"

alias connhome="ssh 73.229.56.138 -p 8822"
alias connjellyfun="connhome -f -N -L 8096:10.0.0.40:8096 >/dev/null 2>&1 &"
alias vault="cd $vault" 
alias projects="cd $projects"
alias todos="rg -e TODO"

starship init fish | source
