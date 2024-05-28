#!/bin/bash

# Update the package lists
sudo dnf update -y

# Install MySQL
sudo dnf install -y mysql-server

# Start MySQL service
sudo systemctl start mysqld

# Enable MySQL service to start on boot
sudo systemctl enable mysqld

# Secure MySQL installation (optional)
# You might want to interactively run `mysql_secure_installation` after this script

# Install Nginx
sudo dnf install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx service to start on boot
sudo systemctl enable nginx

# Print status of MySQL and Nginx services
echo "MySQL and Nginx have been installed and started. Their statuses are as follows:"
sudo systemctl status mysqld
sudo systemctl status nginx
