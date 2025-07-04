resource "aws_instance" "ec2" {
  ami           = data.aws_ami.centos8.image_id
  instance_type = var.instance_type
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
    Name = var.tool
  }
}

resource "aws_route53_record" "record" {
  zone_id = "Z07191123NJU9NTTKKZJ1"
  name    = var.tool
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.public_ip]
}