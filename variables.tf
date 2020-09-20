variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "name" {}
variable "environment" {}
variable "business" {}
variable "department" {}
variable "description" {}
variable "support_team" {}
variable "business_owner" {}
variable "project_code" {}
variable "technical_owner" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "instance_size" {
  default = "t3.large"
}

variable "key_name" {
  description = "SSH key attached to instance"
}

variable "subnet_id" {
  description = "Subnet where the instance need to be started"
}

variable "vpc_id" {
  description = "VPC where the instance will be started"
}

variable "project_name" {
  description = "Give this deployment a name, prefer single words or camel case, this has to match the azure devops project name"
}

variable "autoscaling_policies_enabled" {
  type        = "string"
  default     = "true"
  description = "Whether to create `aws_autoscaling_policy` and `aws_cloudwatch_metric_alarm` resources to control Auto Scaling"
}

variable "enabled" {
  type        = "string"
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "scale_up_cooldown_seconds" {
  type        = "string"
  default     = "300"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_up_scaling_adjustment" {
  default     = 1
  description = "The number of instances by which to scale. `scale_up_adjustment_type` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_up_adjustment_type" {
  type        = "string"
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_up_policy_type" {
  type        = "string"
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "scale_down_cooldown_seconds" {
  type        = "string"
  default     = "300"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_down_scaling_adjustment" {
  default     = -1
  description = "The number of instances by which to scale. `scale_down_scaling_adjustment` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_down_adjustment_type" {
  type        = "string"
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_down_policy_type" {
  type        = "string"
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "cpu_utilization_high_evaluation_periods" {
  type        = "string"
  default     = "2"
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_high_period_seconds" {
  type        = "string"
  default     = "300"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = "string"
  default     = "90"
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_high_statistic" {
  type        = "string"
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = "string"
  default     = "2"
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_low_period_seconds" {
  type        = "string"
  default     = "300"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = "string"
  default     = "10"
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_low_statistic" {
  type        = "string"
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "ec2_enable_monitoring" {
  default     = true
  description = "Turn on extended monitoring?"
}

variable "ec2_user_data" {
  type = "string"

  default     = "templates/provision"
  description = "file with additional script that we want to add into user_data"
}

variable "ebs_block_device_size" {
  type = "string"

  default = "50"
  description = "size of the main mounted volume"
}

variable "azure_devops_agent_token" {
  type = "string"
  description = "generated azure devops api key for agents"
}
