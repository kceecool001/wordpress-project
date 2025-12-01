# Security group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project}-ec2-sg"
  description = "Allow inbound HTTP/SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidrs
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-ec2-sg"
  }
}

# EC2 instance
resource "aws_instance" "main" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(var.public_subnet_ids, 0)
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  iam_instance_profile   = var.iam_instance_profile
  user_data = <<-EOF
              #!/bin/bash
              # Update system
              yum update -y
              
              # Install Apache, PHP, and required tools
              yum install -y httpd php php-mysqlnd awscli unzip
              
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
              EOF
  tags = {
    Name = "${var.project}-ec2"
  }
}