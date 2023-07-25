# WAS to moniter disk usage if the threshould value reached 18 % then send an  emial notification 

#!/bin/bash

# Calculate disk usage percentage of the current directory and store it in 'perc' variable
perc=$(df -h . | awk 'NR==2 {print $5}' | sed 's/%//')

# Check if disk usage is greater than or equal to 18%
if [ "$perc" -ge 18 ]; then
    # If the condition is true, send an email notification
    echo "Memory reached the threshold value." | mail -s "Disk usage" mailaddress@gmail.com
fi
