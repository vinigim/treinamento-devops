terraform {
  backend "remote" {
    organization = "vinigim"

    workspaces {
      name = "treinamento-devops-itau"
    }
  }
}