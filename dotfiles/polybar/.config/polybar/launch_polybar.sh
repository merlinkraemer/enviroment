killall -q polybar

# no race condition pls
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch main bar on DP-0
MONITOR=DP-0 polybar --reload main &

# Launch secondary bar on HDMI-0
MONITOR=HDMI-0 polybar --reload secondary &

