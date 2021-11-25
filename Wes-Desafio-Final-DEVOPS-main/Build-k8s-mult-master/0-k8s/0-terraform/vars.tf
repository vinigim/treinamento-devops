variable "ip_haproxy" {
  type        = string
  default     = "187.3.223.136"
  description = "Passe aqui o IP do haproxy"
}

# variable "subnet_public_ids" {
#   type    = list(string)
#   default = ["aws_subnet.wes_sub_tf_public_a.id, aws_subnet.wes_sub_tf_public_c.id"]
# }

# variable "subnet_priv_ids" {
#   type    = list(string)
#   default = ["aws_subnet.wes_sub_tf_priv_a.id", "aws_subnet.wes_sub_tf_priv_c.id"]
# }

variable "internet_gw" {
  type    = string
  default = "igw-054a2658906c6a922"

}
variable "vpc_id" {
  type    = string
  default = "vpc-0050d085a3350c2c9"

}

