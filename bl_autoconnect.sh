#!/bin/bash
function get_state_bl {
  state_var=false
  if [ "$(bluetoothctl info $DEVICE_MAC | grep -i 'connected' | awk '{print $2}')" == "yes" ]; then
    state_var=true
  fi
  echo "$state_var"
}

MAX_ATTEMPTS=10 # Enter the desired number of attempts
DEVICE_MAC="AA:AA:AA:AA:AA:AA" # Enter the mac of the device you want to connect to
TIME_SLEEP=1 # Enter the desired interval(in seconds) between connection attempts

attempt_counter=0
while (( $attempt_counter < $MAX_ATTEMPTS )) && [[ "$(get_state_bl)" != true ]]
  do
    (( attempt_counter++ ))
    echo "Try to connect $DEVICE_MAC: $attempt_counter"
    bluetoothctl connect $DEVICE_MAC
    sleep $TIME_SLEEP
  done
  

if [[ "$(get_state_bl)" = true ]]; then
  echo "Сonnection to device $DEVICE_MAC is SUCCESSFUL!"
else
  echo "Connection to device $DEVICE_MAC is FAILD!"
fi