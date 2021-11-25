module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "3.5.2"

  name = var.common_name

  # VPC
  cidr            = "10.10.0.0/16"
  azs             = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]

  route53_zone_name = var.dns_zone

  atlantis_github_user = var.github_user
  atlantis_github_user_token = var.github_token

  alb_ingress_cidr_blocks = ["0.0.0.0/0"]
  atlantis_repo_allowlist = ["*"]

  ecs_service_desired_count = 2

  # Atlantis config YAML
  custom_environment_variables = [
    {
      "name" : "ATLANTIS_REPO_CONFIG_JSON",
      "value" : jsonencode(yamldecode(file("${path.module}/server-atlantis.yaml"))),
    },
  ]
}

module "ecs-service-autoscaling" {
  source  = "./modules/ecs-service-autoscaling"
  ecs_cluster_name = var.common_name
  ecs_service_name = var.common_name
  name_prefix = var.common_name
}
