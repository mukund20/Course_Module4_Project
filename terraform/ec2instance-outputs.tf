# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public.public_ip
}

# Private EC2 Instances
## ec2_private_instance_ids
output "ec2_private_app_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private_app.id
}
## ec2_private_ip
output "ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.ec2_private_app.private_ip
}

## ec2_private_instance_ids
output "ec2_private_jenkins_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_private_jenkins.id
}

## ec2_jenkins_ip

output "ec2_jenkins_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.ec2_private_jenkins.private_ip
}
