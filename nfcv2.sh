#!/bin/bash

previous_temperature=""
previous_fan_speed=""

display_info() {
    local temperature=$1
    local fan_speed=$2

    clear  
    echo "╔═══════════════════════════╗"
    echo "  GPU Temperature: $temperature°C   "
    echo "  Fan Speed: $fan_speed%            "
    echo "╚═══════════════════════════╝"
}

# This is where you change your ranges for your fan curve!
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
    fi # Your ranges for temp and fan speed end here!

    # This is where you change you fan labels and gpu label
    if [[ "$fan_speed" != "$previous_fan_speed" ]]; then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=$fan_speed" -a "[fan-1]/GPUTargetFanSpeed=$fan_speed"
        previous_fan_speed=$fan_speed
        clear  
        display_info $temperature $fan_speed
    fi
}


while true; do
    temperature=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

    
    if [[ "$temperature" != "$previous_temperature" ]]; then
        set_fan_speed $temperature
        previous_temperature=$temperature
    fi

    sleep 5 #This is the sleep variable you can change, Gaming 4-8 Productivity 10-30
done
