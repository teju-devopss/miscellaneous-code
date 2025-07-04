data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]  # or however you're passing the VPC ID
  }
}
