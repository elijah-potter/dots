# Stop .lesshst from appearing
set -x LESSHISTFILE -

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

function n
    nvim $argv
end

set -x vault /mnt/vault/

set -x EDITOR nvim

starship init fish | source
