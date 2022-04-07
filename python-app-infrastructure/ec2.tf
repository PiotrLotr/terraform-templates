# resource "aws_instance" "webserver" {
#   ami                         = data.aws_ssm_parameter.webserver-ami.value
#   instance_type               = "t3.micro"
#   key_name                    = aws_key_pair.webserver-key.key_name
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.sg.id]
#   subnet_id                   = aws_subnet.subnet.id
#   provisioner "remote-exec" {
#     inline = [
#       yum update -y
#       amazon-linux-extras install -y php7.2

#       yum install -y httpd
#       systemctl start httpd
#       systemctl enable httpd

#       usermod -a -G apache ec2-user
#       chown -R ec2-user:apache /var/www

#       sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
#       find /var/www -type f -exec sudo chmod 0664 {} \;

#       curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#       chmod +x wp-cli.phar
#       mv wp-cli.phar /usr/local/bin/wp

#       wp core download
#     ]
#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file("~/.ssh/id_rsa")
#       host        = self.public_ip
#     }
#   }
#   tags = {
#     Name = "webserver"
#   }
# }