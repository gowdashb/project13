"""
Question: Write a Bash script to monitor specific services and automatically restart them if they are found 
to be stopped. The services to monitor are sshd and jenkins. The script should periodically check if these 
services are running, and if any of them are not running, it should send an email notification and restart 
the stopped service using systemctl
------------------------------------------------------------------------------------------------------------
"""
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
