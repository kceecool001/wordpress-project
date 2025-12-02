#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
set -xe
# Update system
yum update -y
            
# Install Apache, PHP, and required tools
yum install -y httpd php php-mysqlnd awscli unzip wget curl
              
# Create web directory
mkdir -p /var/www/html
              
# Set permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html
              
# Enable and start Apache
systemctl enable httpd
systemctl start httpd
              
# Configure PHP
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/' /etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 64M/' /etc/php.ini
              
# Restart Apache to apply changes
systemctl restart httpd