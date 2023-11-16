# Get the latest TLS cert from GitHub to authenticate their requests
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}