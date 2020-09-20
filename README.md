# How to 

Create a `main.tf` with the following contents
```
variable "key_name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "project_name" {}
variable "azure_devops_agent_token" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}


module "deployment" {
    source = "github.com/agounaris/terraform-aws-azure-devops-agent"

    aws_access_key = "${var.aws_access_key}"
    aws_secret_key = "${var.aws_secret_key}"
    key_name = "${var.key_name}"
    subnet_id = "${var.subnet_id}"
    vpc_id = "${var.vpc_id}"
    project_name = "${var.project_name}"
    azure_devops_agent_token = "${var.azure_devops_agent_token}"
}
```

and then create a `my.tfvars` file
```
key_name = "a_key_name"
subnet_id = "a_subnet_id"
vpc_id = "a_vpc_id"
project_name = "a name"
azure_devops_agent_token = "your generated azure devops token"
aws_access_key = ""
aws_secret_key = ""
```

And deploy the project with `terraform init`, `terraform plan --var-file my.tfvars` and finally `terraform apply --var-file my.tfvars`