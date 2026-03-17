#!/bin/bash

# Define the target I want to monitor
TARGET="kaizen-flow-central-system"

echo "Starting Kaizen Flow Monitoring Agent..."
echo "Monitoring target: $TARGET"
echo "---------------------------------------"

# WHY: Start an infinite loop to check the connection continuously
while true; do

    # WHY: Send 1 ping (-c 1) and wait a maximum of 2 seconds (-W 2) for a response. Send the output to /dev/null so it doesn't clutter the terminal screen.
    if ping -c 1 -W 2 $TARGET > /dev/null 2>&1; then
        
        # If the ping succeeds, print a success message with the current timestamp
        echo "[$(date +'%T')] SUCCESS: $TARGET is online."
        
    else
        
        # If the ping fails, sound the alarm and trigger the recovery!
        echo "[$(date +'%T')] ERROR: $TARGET is OFFLINE! Connection dropped."
        echo "[$(date +'%T')] Initiating auto-recovery sequence..."
        
        # WHY: Execute the Docker command to restart the failed central system
        docker restart $TARGET
        
        echo "[$(date +'%T')] RECOVERY COMPLETE: $TARGET has been rebooted."
        
        # WHY: Pause for 5 seconds to give the Nginx server time to fully boot up before pinging again
        sleep 5
        
    fi

    # WHY: Wait 3 seconds before running the next check so the CPU is not overloaded
    sleep 3

done