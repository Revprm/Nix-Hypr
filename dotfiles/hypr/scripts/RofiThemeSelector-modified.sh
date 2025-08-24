#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# simple bash script to check if update is available by comparing local version and github version

# Local Paths
local_dir="$HOME/.config/hypr"
iDIR="$HOME/.config/swaync/images/"
local_version=$(ls $local_dir/v* 2>/dev/null | sort -V | tail -n 1 | sed 's/.*v\(.*\)/\1/')
KooL_Dots_DIR="$HOME/Hyprland-Dots"

# exit if cannot find local version
if [ -z "$local_version" ]; then
    notify-send -i "$iDIR/error.png" "ERROR "!?!?!!"" "Unable to find KooL's dots version . exiting.... "
    exit 1
fi

# GitHub URL - KooL's dots
branch="main"
github_url="https://github.com/JaKooLit/Hyprland-Dots/tree/$branch/config/hypr/"

# Fetch the version from GitHub URL - KooL's dots
github_version=$(curl -s $github_url | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | sort -V | tail -n 1 | sed 's/v//')

# Cant find  GitHub URL - KooL's dots version
if [ -z "$github_version" ]; then
    exit 1
fi

# Comparing local and github versions
if [ "$(echo -e "$github_version\n$local_version" | sort -V | head -n 1)" = "$github_version" ]; then
    notify-send -i "$iDIR/note.png" "KooL Hyprland:" "No update available"
    exit 0
else
    # update available
    notify_cmd_base="notify-send -t 10000 -A action1=Update -A action2=NO -h string:x-canonical-private-synchronous:shot-notify"
    notify_cmd_shot="${notify_cmd_base} -i $iDIR/shimarin.jpg"
    
    response=$($notify_cmd_shot "KooL Hyprland:" "Update available! Update now?")
    
    case "$response" in
        "action1")
            if [ -d $KooL_Dots_DIR ]; then
                if ! command -v kitty &> /dev/null; then
                    notify-send -i "$iDIR/error.png" "E-R-R-O-R" "Kitty terminal not found. Please install Kitty terminal."
                    exit 1
                fi
                kitty -e bash -c "
          cd $KooL_Dots_DIR &&
          git stash &&
          git pull &&
          ./copy.sh &&
		  notify-send -u critical -i "$iDIR/shimarin.jpg" 'Update Completed:' 'Kindly log out and relogin to take effect'
                "
                
            else
                if ! command -v kitty &> /dev/null; then
                    notify-send -i "$iDIR/error.png" "E-R-R-O-R" "Kitty terminal not found. Please install Kitty terminal."
                    exit 1
                fi
                kitty -e bash -c "
          git clone --depth=1 https://github.com/JaKooLit/Hyprland-Dots.git $KooL_Dots_DIR &&
          cd $KooL_Dots_DIR &&
          chmod +x copy.sh &&
          ./copy.sh &&
		  notify-send -u critical -i "$iDIR/shimarin.jpg" 'Update Completed:' 'Kindly log out and relogin to take effect'
                "
            fi
        ;;
        "action2")
            exit 0
        ;;
    esac
fi
  IFS='|'
    for themen in ${theme_names[@]}
    do
        echo "${themen}"
    done
    IFS=${OLDIFS}
}

##
# Thee indicate what entry is selected.
##
declare -i SELECTED

select_theme()
{
    local MORE_FLAGS=(-dmenu -format i -no-custom -p "Theme" -markup -config "${TMP_CONFIG_FILE}" -i)
    MORE_FLAGS+=(-kb-custom-1 "Alt-a")
    MORE_FLAGS+=(-u 2,3 -a 4,5 )
    local CUR="default"
    while true
    do
        declare -i RTR
        declare -i RES
        local MESG="""You can preview themes by hitting <b>Enter</b>.
<b>Alt-a</b> to accept the new theme.
<b>Escape</b> to cancel
Current theme: <b>${CUR}</b>
<span weight=\"bold\" size=\"xx-small\">When setting a new theme this will override previous theme settings.
Please update your config file if you have local modifications.</span>"""
        THEME_FLAG=
        if [ -n "${SELECTED}" ]
        then
            THEME_FLAG="-theme ${themes[${SELECTED}]}"
        fi
        RES=$( create_theme_list | ${ROFI} ${THEME_FLAG} ${MORE_FLAGS[@]} -cycle -selected-row "${SELECTED}" -mesg "${MESG}")
        RTR=$?
        if [ "${RTR}" = 10 ]
        then
            return 0;
        elif [ "${RTR}" = 1 ]
        then
            return 1;
        elif [ "${RTR}" = 65 ]
        then
            return 1;
        fi
        CUR=${theme_names[${RES}]}
        SELECTED=${RES}
    done
}

############################################################################################################
# Actual program execution
###########################################################################################################
##
# Find all themes
##
find_themes

##
# Do check if there are themes.
##
if [ ${#themes[@]} = 0 ]
then
    ${ROFI} -e "No themes found."
    exit 0
fi

##
# Create copy of config to play with in preview
##
create_config_copy

##
# Show the themes to user.
##
if select_theme && [ -n "${SELECTED}" ]
then
    # Apply the selected theme
    add_theme_to_config "${theme_names[${SELECTED}]}"

    # Send notification with the selected theme name
    selection="${theme_names[${SELECTED}]}"
    if [ -n "$NOTIFY_SEND" ]; then
        notify-send -u low -i "$iDIR/shimarin.jpg"  "Rofi Theme applied:" "$selection"
    fi
fi

##
# Remove temp. config.
##
rm -- "${TMP_CONFIG_FILE}"
