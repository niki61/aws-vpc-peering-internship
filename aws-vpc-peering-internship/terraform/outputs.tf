output "vpc_a_id" {
  description = "ID of VPC-A"
  value       = aws_vpc.vpc_a.id
}

output "vpc_b_id" {
  description = "ID of VPC-B"
  value       = aws_vpc.vpc_b.id
}

output "peering_connection_id" {
  description = "ID of the VPC Peering Connection"
  value       = aws_vpc_peering_connection.peering_conn.id
}

output "server_a_public_ip" {
  description = "Public IP of Server-A"
  value       = aws_instance.server_a.public_ip
}

output "server_a_private_ip" {
  description = "Private IP of Server-A"
  value       = aws_instance.server_a.private_ip
}

output "server_b_public_ip" {
  description = "Public IP of Server-B"
  value       = aws_instance.server_b.public_ip
}

output "server_b_private_ip" {
  description = "Private IP of Server-B (Target to ping from Server-A)"
  value       = aws_instance.server_b.private_ip
}

output "verification_command" {
  description = "Command to run from Server-A terminal to verify peering"
  value       = "ping -c 4 ${aws_instance.server_b.private_ip}"
}
