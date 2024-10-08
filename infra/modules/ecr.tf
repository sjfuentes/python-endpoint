resource "aws_ecr_repository" "api" {
  name                 = format("%s-example-app", var.prefix)
  force_delete         = true
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
