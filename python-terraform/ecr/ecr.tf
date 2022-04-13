resource "aws_ecr_repository" "ecr" {
  name                 = "app-${terraform.workspace}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
 }
  
  tags = {
   Env = "${terraform.workspace}"
 }

}