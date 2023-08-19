#!/bin/bash

LOW_USAGE_THRESHOLD=50
MEDIUM_USAGE_THRESHOLD=80

check_disk_usage() {
    # Get disk usage as a percentage
    usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

    # Display the result with colors and emojis based on usage level
    if [ "$usage" -lt $LOW_USAGE_THRESHOLD ]; then
        echo -e "\e[32mDisk usage: $usage% 🟢\e[0m"
    elif [ "$usage" -lt $MEDIUM_USAGE_THRESHOLD ]; then
        echo -e "\e[33mDisk usage: $usage% 🟡\e[0m"
    else
        echo -e "\e[31mDisk usage: $usage% 🔴\e[0m"
    fi
}

read -p "Do you want to check disk usage? (Y/N) " answer

# Execute the function if the answer is "Y" or "y"
if [ "$answer" == "Y" ] || [ "$answer" == "y" ]; then
    check_disk_usage
else
    echo "Okay, see you next time! 👋"
fi