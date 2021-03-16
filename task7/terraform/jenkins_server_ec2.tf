# the Jenkins server itself
resource "aws_instance" "jenkins-instance" {
  ami                    		= data.aws_ami.amazon-linux-2.id
  instance_type          		= "t2.micro"
  key_name               		= aws_key_pair.deployer.key_name
  vpc_security_group_ids 		= [aws_security_group.Jenkins.id]
  user_data              		= data.template_file.jenkins_server.rendered

  # associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "Jenkins-Instance"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("files/jenkins_server.pub")
}

resource "aws_eip" "elastic01" {
  instance = aws_instance.jenkins-instance.id
  vpc      = true
}

# Security Group:
resource "aws_security_group" "Jenkins" {
  name        = "Jenkins"
  description = "Jenkins Server: created by Terraform for [devops]"
  vpc_id = data.aws_vpc.default_vpc.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_jenkins_server
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "allow jenkins servers to see the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "jenkins_server_public_ip" {
  value = aws_eip.elastic01.public_ip
}
