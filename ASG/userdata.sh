#!/bin/bash
  # Update the system
  yum -y update
  # Install Apache web server
  yum -y install httpd
  # Start Apache web server
  systemctl start httpd
  # Enable Apache to start at boot
  systemctl enable httpd


  #install mysql client
  yum install -y mysql