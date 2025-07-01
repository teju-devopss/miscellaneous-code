# this will install all the infrastructure for the prometheus server.
data "aws_ami" "centos8" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = [973714476881]
}

terraform {
  backend "s3" {
    bucket = "teju-devops"
    key    = "elasticsearch/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "elasticsearch" {
  ami           = data.aws_ami.centos8.image_id
  instance_type = "m6in.large"
  vpc_security_group_ids = ["sg-05c761dbd36f70805"]
  subnet_id = "subnet-03b0995466039e839"

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type             = "persistent"
    }

  }
  tags = {
    Name = "elasticsearch"
  }
}

resource "aws_route53_record" "elasticsearch" {
  zone_id = "Z07191123NJU9NTTKKZJ1"
  name    = "elasticsearch"
  type    = "A"
  ttl     = 30
  records = [aws_instance.elasticsearch.public_ip]
}

resource "aws_route53_record" "logstash" {
  zone_id = "Z07191123NJU9NTTKKZJ1"
  name    = "logstash"
  type    = "A"
  ttl     = 30
  records = [aws_instance.elasticsearch.private_ip]
}
#here we give private_ip because we are giving instead filebeat.yml


# resource "aws_route53_record" "grafana" {
#   zone_id = "Z07191123NJU9NTTKKZJ1"
#   name    = "grafana"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.prometheus.public_ip]
# }
#
# resource "aws_iam_role" "main" {  # creating role for ec2 instance.
#   name = "prometheus-role"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
#
#   inline_policy {
#     name = "parameter-store"
#
#     policy = jsonencode({
#       "Version": "2012-10-17",
#       "Statement": [
#         {
#           "Sid": "VisualEditor0",
#           "Effect": "Allow",
#           "Action": [
#             "ec2:DescribeInstances",
#             "ec2:DescribeAvailabilityZones"
#           ],
#           "Resource": "*"
#         }
#       ]
#     })
#   }
# }
# resource "aws_iam_instance_profile" "main" {# used to create instance profile ARN Which is automatically created manually but not
#   name = "prometheus-role"
#   role = aws_iam_role.main.name
# }