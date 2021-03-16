# the Jenkins server itself
resource "aws_instance" "frontend-instance" {
  ami                    		= data.aws_ami.amazon-linux-2.id
  instance_type          		= "t2.micro"
  key_name               		= aws_key_pair.deployer.key_name
  vpc_security_group_ids 		= [aws_security_group.frontend-sg.id]
  user_data              		= data.template_file.docker_host_al2.rendered

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "Frontend-Instance"
  }
}

resource "aws_eip" "elastic02" {
  instance = aws_instance.frontend-instance.id
  vpc      = true
}

# Security Group:
resource "aws_security_group" "frontend-sg" {
  name        = "Frontend-sg"
  description = "frontend: created by Terraform for [devops]"
  vpc_id = data.aws_vpc.default_vpc.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_frontend
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "allow frontend to see the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "frontend_public_ip" {
  value = aws_eip.elastic02.public_ip
}
