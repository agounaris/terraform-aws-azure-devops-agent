locals {
  vpc_public_subnets  = [
    data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]
  vpc_private_subnets = [
    data.aws_subnet.private_a.id, data.aws_subnet.private_b.id]

  availability_zones = distinct(sort(list(
    data.aws_subnet.public_a.availability_zone, data.aws_subnet.public_b.availability_zone,
    data.aws_subnet.private_a.availability_zone, data.aws_subnet.private_b.availability_zone
    )))
}

resource "aws_iam_role" "management_role" {
  name = "${var.project_name}-management_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "${var.project_name}-management-role"
    MG_Name = var.project_name
    MG_Business = var.business
    MG_Department = var.department
    MG_ApplicationDesc = var.description
    MG_ProjectName = var.project_name
    MG_ProjectCode = var.project_code
    MG_Environment = var.environment
    MG_SupportTeam = var.support_team
    MG_BusinessOwner = var.business_owner
    MG_TechnicalOwner = var.technical_owner
  }
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_role_form_ssm" {
  role       = aws_iam_role.management_role.name
  policy_arn = data.aws_iam_policy.AmazonEC2RoleforSSM.arn
}

resource "aws_iam_instance_profile" "management_profile" {
  name = "${var.project_name}-management_profile"
  role = aws_iam_role.management_role.name
}

resource "aws_launch_configuration" "this" {
  name                        = "${var.project_name}-${var.name}"
  security_groups             = [
    aws_security_group.instance_sg.id]
  associate_public_ip_address = false

  image_id              = data.aws_ami.ubuntu.id
  instance_type         = var.instance_size
  enable_monitoring     = var.ec2_enable_monitoring
  key_name              = var.key_name
  iam_instance_profile  = aws_iam_instance_profile.management_profile.name

  user_data = data.template_file.user_data_script.rendered

  root_block_device {
    volume_size = var.ebs_block_device_size
    volume_type = "gp2"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true # this is useful for rolling release/ updates
  }
}

resource "aws_autoscaling_group" "default" {
  availability_zones   = local.availability_zones
  vpc_zone_identifier  = local.vpc_private_subnets
  launch_configuration = aws_launch_configuration.this.id

  desired_capacity = "1"
  max_size         = "4"
  min_size         = "1"

  tags = [
    {
      key = "Name"
      value = "azure-devops-agent"
      propagate_at_launch = true
    }
  ]
}
