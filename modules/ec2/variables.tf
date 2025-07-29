variable "instance_type" {}
variable "tool" {}
variable "dns_name" {}
variable "listener_arn" {}
variable "vpc_id" {
  default = "vpc-0b05962ad61b6af8d"
}
variable "port" {}
variable "priority" {}
variable "policy_list" {}