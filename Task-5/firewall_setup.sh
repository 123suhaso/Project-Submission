#!/bin/bash

sudo apt update
sudo apt install ufw -y

# Default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH only from a specific IP
sudo ufw allow from YOUR_PUBLIC_IP to any port 22 proto tcp

# Allow HTTP
sudo ufw allow 80/tcp

# Allow application port
sudo ufw allow 8000/tcp

# Enable firewall
sudo ufw enable

# Verify rules
sudo ufw status numbered