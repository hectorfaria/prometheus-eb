variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_availability_zone" {
  type    = string
  default = "us-east-1e"
}
variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "max_instances" {
  type        = number
  description = "The maximum amount of instances that the load balancer can reach"
  default     = 1
}

variable "solution_stack_name" {
  type        = string
  default     = "64bit Amazon Linux 2 v3.5.9 running Docker"
  description = "The solution stack name, this is need to specify which environment you need"
}

variable "prom_img" {
  type        = string
  description = "The Docker image value"
  default     = "prom/node-exporter"
}
