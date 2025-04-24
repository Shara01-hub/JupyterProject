/*# output ec2 public ip
output "ec2_public_ip" {
  value       = aws_instance.patty_moore_website
  description = "Public IP of the EC2 instance"
}
*/

/* # output domain ip
output "domain_name" {
  value       = aws_lb.application_load_balancer.dns_name
  description = "DNS name of the load balancer"
}
*/