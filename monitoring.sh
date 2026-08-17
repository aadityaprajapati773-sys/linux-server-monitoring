#!/bin/bash

LOG_FILE="./logs/monitor.log"

mkdir -p logs

# Log message function
log_message() {
    echo "$(date): $1 " >> "$LOG_FILE"
}

echo "======================================================" >> "$LOG_FILE"
echo "Monitoring started: $(date)" >> "$LOG_FILE"


# CPU Usage

CPU=$( top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f\n" ,100-$8}')

echo "CPU USAGE: $CPU%" >> "$LOG_FILE"

if [ "$CPU" -gt 75 ]; then
    log_message "WARNING: High CPU usage - $CPU%"  
fi


# Memory Usage

MEMORY=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

echo "MEMORY USAGE: $MEMORY%" >> "$LOG_FILE"

if [ "$MEMORY" -gt 75 ]; then
    log_message "WARNING: High Memory usage - $MEMORY%"   
fi


# Disk Usage

DISK=$(df / | awk 'NR==2 {printf "%.0f\n", $5}' )

echo "DISK USAGE: $DISK%" >> "$LOG_FILE"

if [ "$DISK" -gt 75 ]; then
    log_message "WARNING: High Disk usage - $DISK%"   
fi

#Nginx monitoring

if systemctl is-active --quiet nginx 
then
	echo "Nginx is running"  >> "$LOG_FILE"

else 
	echo "Nginx is Dowm. Restarting....."  >> "$LOG_FILE"

 sudo systemctl restart nginx

   if systemctl is-active --quiet nginx
 then
	 echo "Nginx restarted succesfully"  >> "$LOG_FILE"
 else 
	 echo "ERROR: Nginx restart failed"  >> "$LOG_FILE"

   fi
fi

#copy on aws s3 
aws sts get-caller-identity
aws s3 cp logs/monitor.log s3://bucket name/
	

