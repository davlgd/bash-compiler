#!/bin/bash

echo
echo "Currently running services:"
echo "---------------------------"
echo 

# List the running services
services=$(systemctl list-units --type=service --state=running | grep ".service" | awk '{print $1}')

# Check if any services are running
if [ -z "$services" ]; then
    echo "No services are currently running."
    exit 0
fi

# Display the services
echo "$services"
echo ""

read -p "Do you want to stop a service? (Y/N) " response

if [ "$response" == "Y" ] || [ "$response" == "y" ]; then
    read -p "Enter the name of the service to stop (e.g. apache2.service): " service_name

    if echo "$services" | grep -q "$service_name"; then
        sudo systemctl stop "$service_name"
        echo "$service_name has been stopped."
    else
        echo "Service not found or not running."
    fi
else
    echo "Okay, see you later!"
fi