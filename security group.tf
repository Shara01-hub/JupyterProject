# security group for the web server # terraform aws create security group
resource "aws_security_group" "patty_moore_sg" {
  name        = "patty_moore_website_sg"
  description = "Allow Internet access to the web server http port 80"
  vpc_id      = aws_vpc.patty_moore_website_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "patty_moore_website_sg"
  }
}

# Create security group for the application load balancer
resource "aws_security_group" "patty_moore_alb_sg" {
  name        = "patty_moore_alb_sg"
  description = "Enable HTTP/HTTPS access on port 80/443"
  vpc_id      = aws_vpc.patty_moore_website_vpc.id

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
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
    Name = "patty_moore_alb_sg"
  }
}
