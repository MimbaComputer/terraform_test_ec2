resource "aws_security_group" "mimba_sg" {
  name = "terraform-mimba2-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}






resource "aws_instance" "mimba_ec2" {
  ami                    = "ami-041feb57c611358bd"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mimba_sg.id]
  count = 1


  user_data = <<-EOF
      #!/bin/bash
      # Installation du serveur d'appliation httpd
      sudo yum install -y httpd
      sudo systemctl start httpd
      sudo systemctl enable httpd

      # Personnalisaiton de index.html
      sudo echo "<h1>Mimba le DevOps!</h1> <p><h3>Trop mignon le garçon :-)</h3></p>" > /var/www/html/index.html
      
      # Configuration aws dans ec2
      aws configure set aws_access_key_id ${var.aws_key_name}
      aws configure set aws_secret_access_key ${var.aws_secret_key}
      aws configure set region ${var.aws_region}
      

 EOF

  tags = {
    Name = "mimba_ec2"
    Environment = "dev"
  }
}







# module "mimba_sg" {
#   source = "../security_group/"
#   from_port_http=80
#   to_port_http=80
#   from_port_https=22
#   to_port_https=22
# }
