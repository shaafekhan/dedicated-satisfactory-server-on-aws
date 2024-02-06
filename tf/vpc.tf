resource "aws_vpc" "sfvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true


}

resource "aws_internet_gateway" "sfig" {
    vpc_id = aws_vpc.sfvpc.id
}

resource "aws_subnet" "sfsubnet" {
    vpc_id = aws_vpc.sfvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-central-1a"
    map_public_ip_on_launch = true
  
}

resource "aws_route_table" "sfrtt" {
    vpc_id = aws_vpc.sfvpc.id
  
}


resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.sfsubnet.id
  route_table_id = aws_route_table.sfrtt.id
}

resource "aws_route" "sfrt" {
    route_table_id = aws_route_table.sfrtt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sfig.id
  
}