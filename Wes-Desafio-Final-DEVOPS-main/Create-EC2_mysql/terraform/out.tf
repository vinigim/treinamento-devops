output "mysql_dev" {
  value = [
    "mysql_dev - ${aws_instance.mysql_dev.private_ip } - ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=60 -o StrictHostKeyChecking=no ubuntu@${aws_instance.mysql_dev.private_dns}"
  ]
}
output "mysql_stage" {
  value = [
    "mysql_stage - ${aws_instance.mysql_stage.private_ip } - ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=60 -o StrictHostKeyChecking=no ubuntu@${aws_instance.mysql_stage.private_dns}"
  ]
}
output "mysql_prod" {
  value = [
    "mysql_prod - ${aws_instance.mysql_prod.private_ip } - ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=60 -o StrictHostKeyChecking=no ubuntu@${aws_instance.mysql_prod.private_dns}"
  ]
}
