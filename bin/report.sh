#!/bin/bash

# Simple System Report Script

echo ""
echo "========================================="
echo "🖥️  System Report"
echo "========================================="
echo "Hostname:    $(hostname)"
echo "Username:    $(whoami)"
echo "Uptime:      $(uptime | sed 's/.*up \([^,]*\),.*/\1/')"
echo "OS Version:  $(sw_vers -productVersion)"
echo "Model:       $(sysctl -n hw.model)"
echo "CPU:         $(sysctl -n machdep.cpu.brand_string)"
echo "Memory:      $(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024)) GB"
echo "IP Address:  $(ipconfig getifaddr en0 || echo "Not connected")"
echo "Battery:     $(pmset -g batt | grep -Eo '[0-9]+%')"
echo "========================================="
echo ""
