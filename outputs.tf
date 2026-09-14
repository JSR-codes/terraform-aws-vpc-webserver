output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "web_instance_public_ip" {
  description = "Public IP of the web server. Visit http://<this-ip> after apply finishes"
  value       = aws_instance.web.public_ip
}
