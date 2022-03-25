#!/bin/bash

# Run this script in display 0 - the monitor
export DISPLAY=:0

# If Chromium crashes (usually due to rebooting), clear the crash
#flag so we don't have the annoying warning bar
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

# Run Chromium and open tabs
/usr/bin/chromium-browser --window-size=800,480 --kiosk --window-position=0,0 http://127.0.0.1
