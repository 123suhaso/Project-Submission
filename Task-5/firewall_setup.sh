#!/bin/bash

sudo apt update
sudo apt install ufw -y

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow from YOUR_PUBLIC_IP to any port 22 proto tcp

sudo ufw allow 80/tcp

sudo ufw allow 8000/tcp

sudo ufw enable

sudo ufw status numbered