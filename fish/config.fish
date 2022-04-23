# Stop .lesshst from appearing
export LESSHISTFILE=-

# Remove blacklisted folders from $HOME/.config/
set blacklist gtk-3.0 dconf
for file in $blacklist
    if test -e $HOME/.config/$file
        rm -r $HOME/.config/$file
    end
end

set -x EDITOR nvim

starship init fish | source
