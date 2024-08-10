locals {
  public_subnets  = compact([for subnets in var.subnets : split("-", subnets)[0] == "public" ? subnets : ""])
  private_subnets = compact([for subnets in var.subnets : split("-", subnets)[0] == "private" ? subnets : ""])

  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}