# lookup for the "default" VPC
data "aws_vpc" "default_vpc" {
  default = true
}

# subnet list in the "default" VPC
# The "default" VPC has all "public subnets"
data "aws_subnet_ids" "default_public" {
  vpc_id = data.aws_vpc.default_vpc.id
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.2021*"]
    # values = ["*amazon-ecs-optimized"]
  }
}

data "google_compute_image" "gc_Centos7_image" {
  family  = "centos-7"
  project = "centos-cloud"
}

# userdata for the Jenkins server ...
data "template_file" "jenkins_server" {
  template = file("./scripts/install_jenkins_server.sh")
  vars = {
    jenkins_admin_password = var.jenkins_admin_password
  }
}

# userdata for the hosts with docker ...
data "template_file" "docker_host" {
  template = file("./scripts/install_docker.sh")
}

# userdata for the amazon linux 2 hosts with docker ...
data "template_file" "docker_host_al2" {
  template = file("./scripts/install_docker_amazon.sh")
}