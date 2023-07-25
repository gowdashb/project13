# Shell script to moniter disk usage if the threshould value reached 18 % then send an  emial notification ###
     #!/bin/bash

     # Calculate disk usage percentage of the current directory and store it in 'perc' variable
    
      perc=$(df -h . | awk 'NR==2 {print $5}' | sed 's/%//')

     # Check if disk usage is greater than or equal to 18%
      
      if [ "$perc" -ge 18 ]; then
     # If the condition is true, send an email notification
      echo "Memory reached the threshold value." | mail -s "Disk usage" mailaddress@gmail.com
      fi


### Question: Write a Bash script to monitor specific services and automatically restart them if they are found to be stopped. The services to monitor are sshd and jenkins. The script should periodically check if these services are running, and if any of them are not running, it should send an email notification and restart the stopped service using systemctl.-     ###

     #!/bin/bash

     services="sshd jenkins"

     for i in $services; do
     ps -C "$i" # List of running processes for the service
  
     if [ $? -ne 0 ]; then
     echo "Service $i was stopped." | mail -s "Service Monitor" address@gmail.com
     echo "Service stopped."
     sudo systemctl restart "$i"
     fi
     done



# Write a shell script to reverse the content of the file ###


     #!/bin/bash

     if [ $# -ne 1 ]; then
     echo "Usage: $0 <file>"
     exit 1
     fi

     file="$1"

    # Check if the file exists

    if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
    fi

    # Create a temporary file to store the reversed content

    temp_file=$(mktemp)

    # Reverse the content of the file and save it in the temporary file

    tac "$file" > "$temp_file"

    # Overwrite the original file with the reversed content

    mv "$temp_file" "$file"

    echo "Content of '$file' has been reversed."


    # to execute above script --
    # chmod +x reverse_content.sh
    # ./reverse_content.sh your_file.txt



# Shell script to clean up a old build which retain the recent build and delete all the old builds#####


     #!/bin/bash

     #Define the directory where the builds are stored
     build_dir="/path/to/builds"

     #Number of recent builds to retain
     retain_count=5

     #Check if the build directory exists
     if [ ! -d "$build_dir" ]; then
     echo "Build directory not found: $build_dir"
     exit 1
     fi

     #Change to the build directory
     cd "$build_dir" || exit 1

     #Get a list of build directories sorted by modification time (oldest first)
      build_list=$(ls -t -d */ | grep -E '/[0-9]{4}-[0-9]{2}-[0-9]{2}/' | tail -n +$((retain_count + 1)))

     #Loop through the list and delete old builds
     for build in $build_list; do
     echo "Deleting old build: $build"
     rm -rf "$build"
     done

    echo "Cleanup complete. Retained $retain_count most recent builds."
# to execute 
    #chmod +x cleanup_builds.sh
    #./cleanup_builds.sh

explaination
Putting it all together, the regex pattern '/[0-9]{4}-[0-9]{2}-[0-9]{2}/' 
is used to match directory names that follow the format of YYYY-MM-DD, 
where YYYY represents a four-digit year, MM represents a two-digit month, 
and DD represents a two-digit day. 
For example, 
it would match directories like
/2023-07-25/, /2022-12-01/, etc.



  

# To monitor services and send email notifications when a service is down: chat GPT###


    #!/bin/bash

    # List of services to monitor
    services=("service1" "service2" "service3")

    # Email configuration
    recipient="your_email@example.com"
    subject="Service Status"

   # Function to check the status of a service
    check_service_status() {
    if systemctl is-active "$1" &> /dev/null; then
    echo "$1 is running."
    else
    echo "$1 is NOT running."
    send_notification "$1 is down!"
    fi
}

  # Function to send email notification
    send_notification() {
    echo "$1" | mail -s "$subject" "$recipient"
}

# Main loop to monitor services
    while true; do
     for service in "${services[@]}"; do
         check_service_status "$service"
     done
     sleep 60  # Adjust the sleep duration (in seconds) as needed
     done

