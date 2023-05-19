#!/bin/bash

#
# A script to display the pipewire/wireplumber volume in Waybar
# 
# This is an optimised bash script. wpctl is called once every $DELAY seconds 
# to obtain the default sink volume. No other process is started. 
#
# The waybar configuration should look like that 
# 
# "custom/pipewire": {
#    "tooltip": false,
#    "max-length": 6,
#    "restart-interval": 10,
#    "exec": "exec $HOME/path-to/pw-volume-monitor.bash"
# },
#

# The script is not properly terminated when waybar is restarted.
# This is probably because it is started via '/bin/sh -c "..."' and
# /bin/sh does not always terminate its children processes when it dies.

# A trick is to declare the waybar custom module with
#     "exec": "exec path-to-this-script"
# The second 'exec' is the builtin command that tells /bin/sh to terminate
# and replace itself by the script. Consequently, waybar will send the
# termination signal directly to the script.
# That trick also save a bit of resources (one less process in the background)
#

# Another simple trick is to make the shell script terminate as soon as
# a command fails. In that case, that the 'echo' commands will fail 
# when STDOUT ceases to be valid.
# Anyway, this is always a good idea to stop a script when something
# goes wrong (e.g. wpctl or pipewire not working as expected)
set -e

# Snore is a pure bash implementation of 'sleep' that does not start any subprocess
# https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
snore()
{
    local IFS
    [[ -n "${_snore_fd:-}" ]] || exec {_snore_fd}<> <(:)
    read ${1:+-t "$1"} -u $_snore_fd || :
}


# Delay in seconds between updates
DELAY=0.5

# ICON will be set to an array containing the speaker icons for mute, low, medium, high   
# Multiple sets of text icons are possible: 

# no icons
SET0=("" "" "" "") 


# From the Unicode subset 'Miscellaneous Symbols And Pictographs' (aka emojis).
# On Linux, a few fonts such as Noto Emoji are providing them in full color. 
# VS15 AND VS16 are variation selectors for emoji. If multiple fonts are providing
# emojis, they could be used to select either a monochrome or a color version.
VS15=$'\uFE0E'
VS16=$'\uFE0F'
VS=""  # replace by $VS15 or $VS16 if needed
SET1=(
    $'\U0001F507'"$VS"
    $'\U0001F508'"$VS"
    $'\U0001F509'"$VS"
    $'\U0001F50A'"$VS"
)

# Those are FontAwesome icons. They use the Unicode private plane and so are non standard. 
# See also the Nerd Fonts project:
#    https://github.com/ryanoasis/nerd-fonts
#    https://github.com/ryanoasis/nerd-fonts/releases/
# Those can be a bit wider than other characters so a space can be needed 
SET2=(
    $''
    $'\uf026 '
    $'\uf027 ' 
    $'\uf028 ' 
)

# Choose here your favorite icon set.
ICON=("${SET1[@]}")

while snore $DELAY ; do
 
    # Is it possible to get multiple lines with wpctl?
    # Not sure but lets assume that this is possible. 
    OUT="" 
    INPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    while read LINE ; do
        #
        # The output of wpctl is of the form
        #   Volume: AAAAA.BB
        # or
        #   Volume: AAAAA.BB [MUTED]
        #
        # Where A and B are sequences of digits.
        #  --> B is always of length 2 and A is often of length 1.
        #      However, Pipewire can set the volume to more than 100%
        #      so A may be bigger. 
        #
        if [[ "$LINE" =~ ^Volume:.([0-9]+)\.([0-9]{2})(([[:blank:]]\[MUTED\])?)$ ]] ; then
            if [[ -n "$OUT" ]] ; then
                OUT+=" "
            fi
            # Bash stores the parts of the matched regular expression in BASH_REMATCH
            # 
            # [0] = the whole match
            # [1] = the AAAAA part
            # [2] = the BB part
            # [3] = the MUTED part when found 
            #            
            if [[ -n "${BASH_REMATCH[3]}" ]] ; then
                OUT+="${ICON[0]}MUTE"
            else
                # Numbers starting with 0 are interpeted in octal.
                # That can be prevented by specifying a decimal base as in 10#033
                # Remark: Do not use 'let' to do the math because the script will
                #         terminate (because of 'set -e') when the value is 0
                volume=$(( 10#${BASH_REMATCH[1]}${BASH_REMATCH[2]} ))
                if [[ $volume -gt 50 ]]; then
                    OUT+="${ICON[3]}$volume%%"
                elif [[ $volume -gt 25 ]]; then
                    OUT+="${ICON[2]}$volume%%"
                elif [[ $volume -gt 0 ]]; then
                    OUT+="${ICON[1]}$volume%%"
                else
                    OUT+="${ICON[1]}---"
                fi
            fi
        else
            echo "Warning: Failed to match output of wpctl: '$LINE'" >&2
            exit 1
        fi
    done <<<"$INPUT"

    if [[ -n "$OUT" ]] ; then
       printf "$OUT\n"
    fi
done

exit 0
