locals {
    default_tags = {
        Terraform = "true"
    }
}

provider "aws" {
    region = "ap-northeast-2"

    default_tags {
        tags = local.default_tags
    }
}