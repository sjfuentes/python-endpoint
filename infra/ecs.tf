module "ecs" {
  source                = "./modules/ecs"
  prefix                = var.prefix
  region                = var.region
  vpc_id                = module.network.vpc_id
  private_subnet_ids    = module.network.private_subnets
  alb_target_group_arn  = aws_lb_target_group.tg.arn
  alb_security_group_id = [aws_security_group.lb_sg.id]
}
