#!/bin/bash

if id "suhas" &>/dev/null; then
    echo "User 'suhas' already exists."
else
    useradd -m suhas
    echo "User 'suhas' created successfully."
fi

mkdir -p /opt/container-monitor

chown -R suhas:suhas /opt/container-monitor

chmod -R 700 /opt/container-monitor

ls -ld /opt/container-monitor