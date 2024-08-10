resource "aws_security_group" "lb_sg" {
  name        = format("%s-lb-sg", var.prefix)
  vpc_id      = module.network.vpc_id
  description = "Security Group for Application Load Balancer"

  ingress {
    description = "Allow ALB access to internt on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ALB its own traffic0"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    self        = true
  }

  egress {
    description = "Allow outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_lb" "lb" {
  name               = format("%s-alb", var.prefix)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in module.network.public_subnets : subnet]

  tags = {
    Name = format("%s-alb", var.prefix)
  }
}

resource "aws_lb_target_group" "tg" {
  name        = format("%s-tg", var.prefix)
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = module.network.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200,302"
    path                = "/DevOps"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
