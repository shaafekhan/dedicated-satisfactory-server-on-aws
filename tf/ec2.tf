data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "sfec2int" {
  subnet_id   = aws_subnet.sfsubnet.id
  private_ips = ["10.0.2.10"]
  security_groups = [aws_security_group.sf_instance_sg.id]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "sfi" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.medium"
  availability_zone = "eu-central-1a"
  key_name =  "DS2024-FRANKFURT"
  user_data = file("./install-ansible.sh")
  
  

  network_interface {
    network_interface_id = aws_network_interface.sfec2int.id
    device_index         = 0
  }

  root_block_device {
    volume_size = 128
  }

}