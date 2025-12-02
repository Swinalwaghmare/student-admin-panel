output "bastion_sg_id" {
    value = aws_security_group.bastion.id
    description = "Bastion security group id"  
}

output "alb_public_sg_id" {
    value = aws_security_group.alb_public.id
    description = "Public ALB security group id"
}

output "alb_internal_sg_id" {
    value = aws_security_group.alb_internal.id
    description = "Internal ALB security group id"
}

output "frontend_sg_id" {
    value = aws_security_group.frontend.id
    description = "Frontend EC2 security group id"
}

output "backend_sg_id" {
    value = aws_security_group.backend.id
    description = "Backend EC2 security group id"
}

output "rds_sg_id" {
    value = aws_security_group.rds.id
    description = "RDS security group id"
}