resource "aws_key_pair" "my-key-2" {

  key_name   = "my-key-2o"
  public_key = file("my-key-2o.pub")
  
  tags = {
    Name        = "my-key-2o"
    Environment = var.env
  }
}

resource "aws_default_vpc" "default" {
  
}
resource "aws_security_group" "my-sec-grp" {
  
  name = "my-sec-grpp"
  description = "Security group for my EC2 instance"
  vpc_id = aws_default_vpc.default.id

  ingress  {
    from_port   = 22
    to_port     = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress  {
    from_port   = 80
    to_port     = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress{
  from_port =0
  to_port = 0
  protocol = -1
  cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "my-sec-grpp"
    Environment = var.env
  }

}

resource "aws_instance" "my-instance" {

  for_each = tomap ( {
    master-server-js = "ami-01f23391a59163da9"
    server-1-js = "ami-0253a7ea84bc17a73"
    server-2-js = "ami-0253a7ea84bc17a73"
    server-3-js = "ami-01f23391a59163da9"
  })
  
  depends_on = [ aws_security_group.my-sec-grp, aws_key_pair.my-key-2 ]
  ami = each.value
  instance_type = "t2.micro"
  key_name = aws_key_pair.my-key-2.key_name
  security_groups = [aws_security_group.my-sec-grp.name]

root_block_device {
  volume_size = 8
  volume_type = "gp2"
}

user_data = file("jass.sh")

  tags = {
    Name = "${each.key}-poing"
    Environment = var.env
}

}