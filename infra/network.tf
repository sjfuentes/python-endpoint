
module "network" {
  source = "terraform-aws-modules/vpc/aws"
  name   = format("%s-network-resource", var.prefix)
  cidr   = var.vpc_cidr

  azs = local.azs

  vpc_tags = {
    Name = format("%s-vpc", var.prefix)
  }
  public_subnets       = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, k)]
  public_subnet_names  = local.public_subnets
  public_subnet_suffix = "subnet"
  public_route_table_tags = {
    Name = format("%s-public_rt", var.prefix)
  }


  private_subnets       = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, k + 2)]
  private_subnet_names  = local.private_subnets
  private_subnet_suffix = "subnet"
  private_route_table_tags = {
    Name = format("%s-private_rt", var.prefix)
  }

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  igw_tags = {
    Name = format("%s-igtw", var.prefix)
  }
  nat_gateway_tags = {
    Name = format("%s-nat-gateway", var.prefix)
  }
  nat_eip_tags = {
    Name = format("%s-elastic-ip", var.prefix)
  }

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false
}
