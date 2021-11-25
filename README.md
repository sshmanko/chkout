# Atlantis setup demo
This is a Terraform demo for setting up Atlantis service on AWS Fargate.

# Installation
Prerequisites:
- AWS credentials (.aws/credentials or ENV VARS) [details](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
- Route53 DNS Managed zone
- GitHub user and [Personal Access Token](https://github.com/settings/tokens/new)

Setup steps:
1. `terraform init`
2. `terraform apply -var github_user="<user>" -var github_token="<token>" -var dns_zone="<zone>"`
3. Add a webhook to GitHub repository: [Howto](https://www.runatlantis.io/docs/configuring-webhooks.html#github-github-enterprise)

   - Set **Payload URL** to *atlantis_url_events* value
   - **Secret** value can be found in *terraform.tfstate* or by running:

   `aws ssm get-parameters --name '/atlantis/webhook/secret' --with-decryption`

# Notes
**ecs-service-autoscaling** module was modified to include *Memory* alerts as requested.

This workflow was tested on my old repository:
https://github.com/sshmanko/webapp/pull/1


Atlantis URL in AWS:
https://atlantis.aws.pingtool.org/
