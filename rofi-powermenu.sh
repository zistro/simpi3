#!/bin/bash

# Define the options for the power menu
options=("Logout" "Reboot" "Shutdown" "Suspend" "Hibernate")

# Use rofi to display the options
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Power Menu")

# Execute the chosen option
case $choice in
    "Logout")
        i3-msg exit
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Hibernate")
        systemctl hibernate
        ;;
    *)
        exit 1
        ;;
esac

