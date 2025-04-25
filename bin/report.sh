#!/bin/bash

# Simple Cross-Platform System Report Script

echo ""
echo "========================================="
echo "🖥️  System Report"
echo "========================================="

OS="$(uname)"

echo "Hostname:    $(hostname)"
echo "Username:    $(whoami)"
echo "Uptime:      $(uptime -p 2>/dev/null || uptime)"
echo "OS Type:     $OS"

if [[ "$OS" == "Darwin" ]]; then
  echo "OS Version:  $(sw_vers -productVersion)"
  echo "Model:       $(sysctl -n hw.model)"
  echo "CPU:         $(sysctl -n machdep.cpu.brand_string)"
  echo "Memory:      $(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024)) GB"
  echo "IP Address:  $(ipconfig getifaddr en0 || echo "Not connected")"
  echo "Battery:     $(pmset -g batt | grep -Eo '[0-9]+%' || echo "No battery info")"
elif [[ "$OS" == "Linux" ]]; then
  echo "OS Version:  $(lsb_release -ds 2>/dev/null || cat /etc/*release | grep PRETTY_NAME | cut -d= -f2- | tr -d '\"')"
  echo "Model:       $(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null || echo "Unknown")"
  echo "CPU:         $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ //')"
  echo "Memory:      $(free -g | awk '/^Mem:/ { print $2 " GB" }')"
  echo "IP Address:  $(hostname -I | awk '{print $1}' || echo "Not connected")"
  echo "Battery:     $(upower -i $(upower -e | grep BAT) 2>/dev/null | grep -E "percentage" | awk '{print $2}' || echo "No battery info")"
else
  echo "Unsupported OS"
fi

echo "========================================="
echo ""

