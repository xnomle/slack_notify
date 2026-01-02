resource "aws_instance" "test_ec2_instance" {
  ami           = "ami-038013fbee7451346"
  instance_type = "t3.micro"

  tags = {
    Name = "Ec2_test_instance"
  }
}