terraform {
  backend "remote" {
    organization = "cabron-Invest"

    workspaces {
      name = "treinamento"
    }
  }
}
