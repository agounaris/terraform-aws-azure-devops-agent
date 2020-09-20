data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

data "aws_iam_policy" "AmazonEC2RoleforSSM" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

data "template_file" "user_data_script" {
  template = file("${path.module}/templates/provision")

  vars = {
    # pointing at empty `.dummy_file_name` is sorting out issues with terraform runtime evaluation
    # user_data = "${ var.ec2_user_data == ".dummy_file_name" ? "" : "${file(var.ec2_user_data)}"}"
    azure_devops_agent_token = var.azure_devops_agent_token
    project_name = var.project_name
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnet" "private_a" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:Name"
    values = ["*private_subnet_a"]
  }
}

data "aws_subnet" "private_b" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:Name"
    values = ["*private_subnet_b"]
  }
}

data "aws_subnet" "public_a" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:Name"
    values = ["*public_subnet_a"]
  }
}

data "aws_subnet" "public_b" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:Name"
    values = ["*public_subnet_b"]
  }
}
