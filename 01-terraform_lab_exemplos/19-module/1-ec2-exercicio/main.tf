provider "aws" {
  region = "us-east-1"
}

module "criar_instancia" {
<<<<<<< HEAD
  source = "git@github.com:vinigim/gitisolado.git"
=======
  source = "./instancia"
  nome = "Um nome"
>>>>>>> ccb2fe85ec0b45127922c8e264a0a31d71f77830
}
