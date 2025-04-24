resource "aws_instance" "patty_moore_website" {
  ami                         = "ami-07a6f770277670015"
  instance_type               = "t2.micro"
  key_name                    = "patty_more_key01"
  subnet_id                   = aws_subnet.patty_moore_website_public_subnet_az1a.id
  vpc_security_group_ids      = [aws_security_group.patty_moore_sg.id]
  associate_public_ip_address = true
  user_data                   = <<-EOF
 #!/bin/bash
sudo su
yum update -y
yum install -y httpd
cd /var/www/html
wget https://github.com/Ahmednas211/jupiter-zip-file/raw/main/jupiter-main.zip
unzip jupiter-main.zip
cp -r jupiter-main/* /var/www/html
rm -rf jupiter-main jupiter-main.zip
systemctl start httpd
systemctl enable httpd 
EOF

  tags = {
    Name = "patty_moore_instance"
  }
}

