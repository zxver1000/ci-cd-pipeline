# Needed for adding to your Github Action
output "role_arn" {
  value = aws_iam_role.gha_oidc_assume_role.arn
}
