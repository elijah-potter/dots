function wallpapertext --description 'Set the text rendered on the desktop wallpaper'
    set -l text (string join ' ' -- $argv)

    if test -z "$text"
        echo "usage: wallpapertext TEXT" >&2
        return 1
    end

    printf '%s\n' "$text" > /home/elijahpotter/.config/wallpapers/hero_text.txt
end
