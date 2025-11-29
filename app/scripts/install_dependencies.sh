#!/bin/bash
yum update -y
yum install -y httpd php php-mysqlnd unzip aws-cli
systemctl enable httpd
