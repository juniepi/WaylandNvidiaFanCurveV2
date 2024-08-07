#!/bin/bash

# Defining temp!
set_fan_speed() {
    local temperature=$1
# Please Refer to Wayland nvidia fan curve project the original! I will note you will have to also change fan_speed= to whatever you change as well!
    if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=50" -a "[fan-1]/GPUTargetFanSpeed=50"
        fan_speed=50
    elif ((temperature >= 51 && temperature <= 63)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=65" -a "[fan-1]/GPUTargetFanSpeed=65"
        fan_speed=65
    elif ((temperature >= 64 && temperature <= 70)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=85" -a "[fan-1]/GPUTargetFanSpeed=85"
        fan_speed=85
    elif ((temperature >= 71 && temperature <= 100)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=100" -a "[fan-1]/GPUTargetFanSpeed=100"
        fan_speed=100
    fi
}

# Main loop to monitor temperature every 30 seconds
while true; do
    temperature=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
    set_fan_speed $temperature
    
    tput clear
    
    echo "╔═══════════════════════════╗"
    echo "  GPU Temperature: $temperature°C   "
    echo "  Fan Speed: $fan_speed%            "
    echo "╚═══════════════════════════╝"

    # This is where you change how many seconds it takes for your fan to update 5-15 for gaming, 30-60 for productivity
    sleep 5
done
