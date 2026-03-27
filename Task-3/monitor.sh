#!/bin/bash

CONTAINER_NAME="docker-web-container"

LOG_FILE="/opt/container-monitor/logs/container_usage.log"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

STATS=$(sudo docker stats --no-stream --format "{{.CPUPerc}}, {{.MemUsage}}" $CONTAINER_NAME 2>/dev/null)

if [ -n "$STATS" ]; then
    echo "$TIMESTAMP | Container: $CONTAINER_NAME | CPU: $(echo $STATS | cut -d',' -f1) | Memory: $(echo $STATS | cut -d',' -f2)" >> $LOG_FILE
else
    echo "$TIMESTAMP | Container: $CONTAINER_NAME | Status: Not Running" >> $LOG_FILE
fi