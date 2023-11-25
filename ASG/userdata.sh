#!/bin/bash
  # Update the system
  sudo yum -y update
  # Install Apache web server
  sudo yum -y install httpd
  # Start Apache web server
  sudo systemctl start httpd.service
  # Enable Apache to start at boot
  sudo systemctl enable httpd.service