#!/bin/bash

# Check if the 'vagrant' command is available in the system's PATH
if command -v vagrant &> /dev/null; then
    echo "Vagrant is installed."
else
    echo "Vagrant is not installed. Please install Vagrant first."
fi

# Create a Vagrantfile with the following contents
cat > Vagrantfile << EOL
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Define the 'Master' Node
  config.vm.define "Master" do |master_config|
    master_config.vm.box = "ubuntu/bionic64"
    config.vm.network "private_network", ip: "192.168.33.10"
    master_config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end

    # Provisioning for the 'Master' Node (LAMP stack, user setup, file copy, and process display)
    master_config.vm.provision "shell", inline: <<-SHELL
      # Update and install required packages
      sudo apt-get update
      sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install apache2 php libapache2-mod-php mysql-server php-mysql

      # Pre-set the MySQL root password to avoid prompts
      sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password your_mysql_root_password_here"
      sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password your_mysql_root_password_here"

      # Install MySQL without interactive prompts
      sudo apt-get -y install mysql-server

      # Start and enable Apache to run on boot
      sudo systemctl start apache2
      sudo systemctl enable apache2

      # Validate PHP functionality with Apache
      echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

      # Create a user named "altschool" with root privileges
      sudo useradd -m -s /bin/bash altschool
      echo 'altschool:your_password_here' | sudo chpasswd
      sudo usermod -aG sudo altschool

      # Generate an SSH key pair for the 'altschool' user
      sudo -u altschool ssh-keygen -t rsa -N "" -f /home/altschool/.ssh/id_rsa

      # Create a directory and some files in /mnt/altschool
      sudo mkdir -p /mnt/altschool
      sudo touch /mnt/altschool/sample_file.txt
      sudo chown -R altschool:altschool /mnt/altschool

      # Display an overview of currently running processes
      ps aux
    SHELL
  end

  # Define the 'Slave' Node
  config.vm.define "Slave" do |slave_config|
    slave_config.vm.box = "ubuntu/bionic64"
    config.vm.network "private_network", ip: "192.168.33.11"
    slave_config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end

    # Provisioning for the 'Slave' Node (LAMP stack)
    slave_config.vm.provision "shell", inline: <<-SHELL
      # Update and install required packages
      sudo apt-get update
      sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install apache2 php libapache2-mod-php mysql-server php-mysql

      # Pre-set the MySQL root password to avoid prompts
      sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password your_mysql_root_password_here"
      sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password your_mysql_root_password_here"

      # Install MySQL without interactive prompts
      sudo apt-get -y install mysql-server

      # Start and enable Apache to run on boot
      sudo systemctl start apache2
      sudo systemctl enable apache2

      # Validate PHP functionality with Apache
      echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
    SHELL
  end

# Define the Load Balancer Node
config.vm.define "LoadBalancer" do |lb_config|
  lb_config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "192.168.33.12"
  lb_config.vm.provider "virtualbox" do |vb|
    vb.memory = 512
    vb.cpus = 1
  end

  # Provisioning for the Load Balancer Node (Install and configure Nginx)
  lb_config.vm.provision "shell", inline: <<-SHELL
    # Update and install Nginx
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install nginx

    # Configure Nginx as a simple load balancer
    echo "upstream backend {
        server 192.168.33.10;
        server 192.168.33.11;  
    }
    
    server {
        listen 80;
        server_name localhost;
        location / {
            proxy_pass http://backend;
        }
    }" | sudo tee /etc/nginx/sites-available/loadbalancer
    
    sudo ln -s /etc/nginx/sites-available/loadbalancer /etc/nginx/sites-enabled/
    sudo nginx -t
    sudo systemctl restart nginx
  SHELL
end 
end
EOL

# Use 'vagrant up' to create and start the virtual machines
vagrant up

echo "viola,deployment completed"

echo "For the 'Master' node: http://192.168.33.10/info.php"
echo "For the 'Slave' node: http://192.168.33.11/info.php"