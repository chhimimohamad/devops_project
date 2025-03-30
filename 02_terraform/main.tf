data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

locals {

  am_id         = data.aws_ami.ubuntu.id
  filename      = "./keypair/${var.stack}.pem"
  instance_name = var.stack
}


module "keypair" {
  source   = "./modules/keypair"
  key_name = var.stack
  filename = local.filename
}

module "security_groups" {
  source               = "./modules/security_group"
  security_group_name  = var.security_group_name
  security_group_ports = var.security_group_ports
  protocol             = var.protocol
  depends_on           = [module.keypair]
}


module "ec2_docker" {

  source              = "./modules/docker"
  ami                 = local.am_id
  key_name            = var.stack
  private_key_path    = local.filename
  username            = var.username
  security_group_name = module.security_groups.sg_name
  instance_name       = local.instance_name
  instance_type       = var.instance_type
  count               = var.stack == "docker" ? 1 : 0
  depends_on          = [module.keypair]

}

module "ec2_kubernetes" {

  source              = "./modules/kubernetes"
  ami                 = local.am_id
  key_name            = var.stack
  private_key_path    = local.filename
  username            = var.username
  security_group_name = module.security_groups.sg_name
  instance_name       = local.instance_name
  instance_type       = var.instance_type
  count               = var.stack == "kubernetes" ? 1 : 0
  depends_on          = [module.keypair]

}