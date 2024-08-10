resource "aws_ecs_cluster" "this" {
  name = format("%s-ecs-cluster", var.prefix)
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = format("/ecs/%s", var.prefix)
  retention_in_days = 7
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
    base              = 1
  }
}

resource "aws_ecs_service" "this" {
  name                               = format("%s-ecs-service", var.prefix)
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this.arn
  launch_type                        = "FARGATE"
  propagate_tags                     = "SERVICE"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 60

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "example_app"
    container_port   = 5000
  }

  lifecycle {
    ignore_changes = [desired_count, capacity_provider_strategy]
  }

  depends_on = [
    aws_ecs_cluster.this
  ]
}

resource "aws_security_group" "ecs" {
  name   = format("%s-ecs-sg", var.prefix)
  vpc_id = var.vpc_id

  ingress {
    description     = "Allow ALB access to ECS on port 5000"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = var.alb_security_group_id
  }

  egress {
    description      = "Allow outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
