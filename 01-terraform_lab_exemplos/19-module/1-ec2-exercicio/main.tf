provider "aws" {
  region = "us-east-1"
}

module "criar_instancia" {
  source = "git@github.com:vinigim/gitisolado.git"
}
