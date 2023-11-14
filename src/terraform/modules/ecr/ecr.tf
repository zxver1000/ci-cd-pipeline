resource "aws_ecr_repository" "foo" {
 # count = data.external.check_repo.result.success == "true" ? 0 : 1
  name = var.repository_name
  force_delete=true
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}