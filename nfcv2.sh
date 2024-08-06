#!/bin/bash

previous_temperature=""

# Function to display information with formatted output
display_info() {
    local temperature=$1
    local fan_speed=$2

    clear  
    echo "╔═══════════════════════════╗"
    echo "  GPU Temperature: $temperature°C   "
    echo "  Fan Speed: $fan_speed%            "
    echo "╚═══════════════════════════╝"
}

# Function to set fan speed based on temperature 
#THIS PART WAS UPDATED TO FIX SUDO ISSUES PLEASE REFER TO V1 TO CUSTOMIZE THE TEMPS AND FAN SPEEDS
set_fan_speed() {
    local temperature=$1
    local fan_speed=""

    if ((temperature >= 0 && temperature <= 35)); then
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        fan_speed=50
    elif ((temperature >= 51 && temperature <= 63)); then
        fan_speed=65
    elif ((temperature >= 64 && temperature <= 70)); then
        fan_speed=85
    elif ((temperature >= 71 && temperature <= 100)); then
        fan_speed=100
    fi

    # Apply fan speed changes (always apply regardless of previous state)
    sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=$fan_speed" -a "[fan-1]/GPUTargetFanSpeed=$fan_speed"
    display_info $temperature $fan_speed
}

# Main loop to monitor temperature and adjust fan speed
while true; do
    temperature=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

    if [[ "$temperature" != "$previous_temperature" ]]; then
        set_fan_speed $temperature
        previous_temperature=$temperature
    fi

    sleep 10 # Adjust the sleep duration as needed
done

