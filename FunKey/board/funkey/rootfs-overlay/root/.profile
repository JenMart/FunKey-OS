# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export TERM=xterm
export LS_OPTIONS='--color=auto'
#eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Resize the console to the terminal dimensions
resize() {
    if [[ -t 0 && $# -eq 0 ]]; then
        local IFS='[;' escape geometry x y
        echo -ne '\e7\e[r\e[999;999H\e[6n\e8'
        read -sd R escape geometry
        x=${geometry##*;} y=${geometry%%;*}
        if [[ ${COLUMNS} -eq ${x} && ${LINES} -eq ${y} ]]; then
            echo "${TERM} ${x}x${y}"
        else
            echo "${COLUMNS}x${LINES} -> ${x}x${y}"
            stty cols ${x} rows ${y}
        fi
    else
        print 'Usage: resize'
    fi
}


# Start ampli if necessary
echo "Start audio amplifier if necessary"
if [[ "$(volume_get)" -ne "0" ]]; then
        start_audio_amp 1 >/dev/null 2>&1
fi

# Force unmute sound card and reset volume
echo "Force unmute sound card and reset volume"
volume_set $(volume_get) >/dev/null 2>&1

# Reset saved brightness
echo "Reset saved brightness"
brightness_set $(brightness_get) >/dev/null 2>&1

# Start Assembly tests (blocking process)
assembly_tests >/dev/null 2>&1

# Start launcher
echo "Start launcher"
start_launcher >/dev/null 2>&1 &
