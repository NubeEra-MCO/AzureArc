#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install MySQL server
echo "Installing MySQL server..."
sudo apt-get install -y mysql-server

# Secure MySQL installation (optional, interactive)
# Uncomment the following line if you want to run the secure installation interactively
# sudo mysql_secure_installation

# Install Nginx
echo "Installing Nginx..."
sudo apt-get install -y nginx

# Start and enable MySQL service
echo "Starting and enabling MySQL service..."
sudo systemctl start mysql
sudo systemctl enable mysql

# Start and enable Nginx service
echo "Starting and enabling Nginx service..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Print status of MySQL and Nginx
echo "MySQL service status:"
sudo systemctl status mysql | grep "Active:"

echo "Nginx service status:"
sudo systemctl status nginx | grep "Active:"

echo "Installation completed successfully!"
