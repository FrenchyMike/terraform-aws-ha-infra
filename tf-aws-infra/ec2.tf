# Security Group for EC2 Instances
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.mike_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instances with Apache
resource "aws_instance" "web" {
  count         = 2
  ami           = var.AWS_AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  subnet_id     = element(aws_subnet.mike_public_subnets.*.id, count.index)
  security_groups = [aws_security_group.ec2_sg.id]
  user_data     = <<-EOF
            #!/bin/bash
            sudo apt-get update
            sudo apt-get install -y apache2
            sudo systemctl start apache2
            sudo systemctl enable apache
            echo "<html><body><h1>Hostname: $(hostname)</h1></body></html>" > /var/www/html/index.html
            EOF

}