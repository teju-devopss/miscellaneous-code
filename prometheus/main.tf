data "aws_ami" "centos8" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = [973714476881]
}

terraform {
  backend "s3" {
    bucket = "teju-devops"
    key    = "prometheus/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "prometheus" {
  ami           = data.aws_ami.centos8.image_id
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-05c761dbd36f70805"]
}

resource "aws_route53_record" "prometheus" {
  zone_id = "Z07191123NJU9NTTKKZJ1"
  name    = "prometheus"
  type    = "A"
  ttl     = 30
  records = [aws_instance.prometheus.private_ip]
}

resource "aws_route53_record" "prometheus-public" {
  zone_id = "Z07191123NJU9NTTKKZJ1"
  name    = "prometheus-public"
  type    = "A"
  ttl     = 30
  records = [aws_instance.prometheus.public_ip]
}