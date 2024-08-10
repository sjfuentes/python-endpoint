variable "prefix" {
  type        = string
  description = "Unique identifier for the resources"
}

variable "region" {
  type        = string
  description = "AWS region where the resources are going to be allocated"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The list of the privates subnets names"
}

variable "alb_security_group_id" {
  type        = list(string)
  description = "Listo of the Load Balancer Security Group to allow ingress traffic to ECS"
}

variable "vpc_id" {
  type        = string
  description = "VPC id to attach the security group"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ARN of the load balancer TG"
}

