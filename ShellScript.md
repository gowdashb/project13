# all in one shell scripts

   #!/bin/bash

# Function to monitor disk usage and send email notification if threshold is reached

    monitor_disk_usage() {
    perc=$(df -h . | awk 'NR==2 {print $5}' | sed 's/%//')

    if [ "$perc" -ge 18 ]; then
        echo "Memory reached the threshold value." | mail -s "Disk usage" mailaddress@gmail.com
    fi
    }

# Function to monitor services, send email notifications, and restart if stopped
    monitor_and_restart_services() {
    services=("sshd" "jenkins")

    for service in "${services[@]}"; do
        ps -C "$service" &> /dev/null

        if [ $? -ne 0 ]; then
            echo "Service $service was stopped." | mail -s "Service Monitor" address@gmail.com
            echo "Service stopped."
            sudo systemctl restart "$service"
        fi
    done
    }

# Function to reverse content of a file
    reverse_content() {
     if [ $# -ne 1 ]; then
        echo "Usage: $0 <file>"
        exit 1
     fi

     file="$1"

     if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found."
        exit 1
     fi

    temp_file=$(mktemp)
    tac "$file" > "$temp_file"
    mv "$temp_file" "$file"

    echo "Content of '$file' has been reversed."
    }

# Function to clean up old builds and retain the recent ones
    cleanup_builds() {
    build_dir="/path/to/builds"
    retain_count=5

    if [ ! -d "$build_dir" ]; then
        echo "Build directory not found: $build_dir"
        exit 1
    fi

    cd "$build_dir" || exit 1

    build_list=$(ls -t -d */ | grep -E '/[0-9]{4}-[0-9]{2}-[0-9]{2}/' | tail -n +$((retain_count + 1)))

    for build in $build_list; do
        echo "Deleting old build: $build"
        rm -rf "$build"
    done

    echo "Cleanup complete. Retained $retain_count most recent builds."
    }

# Main script

     case "$1" in
     "disk-usage")
        monitor_disk_usage
        ;;
     "monitor-services")
        monitor_and_restart_services
        ;;
     "reverse-content")
        reverse_content "$2"
        ;;
     "cleanup-builds")
        cleanup_builds
        ;;
     *)
        echo "Usage: $0 [disk-usage | monitor-services | reverse-content <file> | cleanup-builds]"
        exit 1
        ;;
      esac
