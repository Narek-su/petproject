data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20250712"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
