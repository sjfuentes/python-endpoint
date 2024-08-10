variable "prefix" {
  type        = string
  description = "Unique identifier for the resources"
}

variable "region" {
  type        = string
  description = "AWS region where the resources are going to be allocated"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range of the VPC"
}

variable "subnets" {
  type        = list(string)
  description = "The list of the subnets names"
}
