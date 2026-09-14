# AWS VPC + Web Server, Provisioned with Terraform

Infrastructure-as-Code project that provisions a custom AWS network from scratch — VPC, public/private subnets, routing, security groups, and an EC2 web server — entirely through Terraform. No manual console clicking.

## Architecture

```
                        Internet
                            │
                    ┌───────▼────────┐
                    │ Internet Gateway│
                    └───────┬────────┘
                            │
                      ┌─────▼─────┐
                      │    VPC     │  10.0.0.0/16
                      │            │
        ┌─────────────┼────────────┼─────────────┐
        │             │            │             │
┌───────▼────────┐    │    ┌───────▼────────┐    │
│ Public Subnet   │    │    │ Private Subnet │    │
│ 10.0.1.0/24     │    │    │ 10.0.2.0/24    │    │
│                 │    │    │ (reserved for  │    │
│ ┌─────────────┐ │    │    │  a future DB)  │    │
│ │ EC2 (nginx) │ │    │    └────────────────┘    │
│ └─────────────┘ │    │                          │
└─────────────────┘    └──────────────────────────┘
```

## What this demonstrates

- Writing reusable, parameterized Terraform (variables, outputs, data sources)
- Designing a VPC with proper public/private subnet separation
- Security group configuration following least-privilege (SSH restricted to a single IP)
- Bootstrapping a server with `user_data` on first boot
- Clean IaC repo hygiene (`.gitignore` for state files and secrets, example tfvars)

## Tech stack

Terraform · AWS (VPC, EC2, Internet Gateway, Route Tables, Security Groups) · nginx · Ubuntu 22.04

## Prerequisites

- An AWS account ([free tier](https://aws.amazon.com/free/) is enough)
- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured with credentials (`aws configure`)
- An existing EC2 key pair in your target region ([create one here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html))

## Usage

```bash
# 1. Clone the repo
git clone https://github.com/JSR-codes/terraform-aws-vpc-webserver.git
cd terraform-aws-vpc-webserver

# 2. Copy the example variables file and fill in your own values
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars: set your key_name and my_ip

# 3. Initialize, review, and apply
terraform init
terraform plan
terraform apply

# 4. Visit the site
# Terraform will print web_instance_public_ip in the outputs — open http://<that-ip>
```

## Cleanup

This project creates billable AWS resources (EC2 instance). Destroy them when you're done to avoid charges:

```bash
terraform destroy
```

## Possible extensions

- Add a NAT Gateway so the private subnet has outbound internet access
- Add an RDS instance in the private subnet
- Add an Application Load Balancer in front of the EC2 instance
- Convert into a reusable Terraform module
- Add a GitHub Actions workflow to run `terraform plan` on every pull request

## License

MIT
