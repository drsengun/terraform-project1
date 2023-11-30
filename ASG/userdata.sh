#!/bin/bash
  # Update the system
  sudo yum -y update
  # Install Apache web server
  sudo yum -y install httpd
  # Start Apache web server
  sudo systemctl start httpd
  # Enable Apache to start at boot
  sudo systemctl enable httpd

  set -xe
  sudo yum install httpd php php-mysql*  wget  -y
  sudo wget https://en-gb.wordpress.org/latest-en_GB.tar.gz
  sudo tar -xf latest-en_GB.tar.gz
  sudo rm -rf /var/www/html/*
  sudo mv wordpress/* /var/www/html/
  sudo chown -R apache:apache /var/www/html
  echo "export WORDPRESS_DB_HOST=wordpressdb.bluegeezer.com" | sudo tee /etc/profile.d/wordpress.sh
  echo "export WORDPRESS_DB_NAME=wordpress" | sudo tee -a /etc/profile.d/wordpress.sh
  echo "export WORDPRESS_DB_USER=foo" | sudo tee -a /etc/profile.d/wordpress.sh
  echo "export WORDPRESS_DB_PASSWORD=foobarbaz" | sudo tee -a /etc/profile.d/wordpress.sh
  sudo systemctl restart httpd