variable "prefix" {
  type        = string
  description = "Unique identifier for the resources"
  default     = "sjfuentes"
}

variable "region" {
  type        = string
  description = "AWS region where the resources are going to be allocated"
  default     = "eu-central-1"
}

variable "repo_name"{
  type = string
  description = "Name of the repository"
  default = "sjfuentes/python-endpoint"
}
