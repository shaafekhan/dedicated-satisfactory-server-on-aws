resource "aws_security_group" "sf_instance_sg" {
    name = "sf_instance_sg"
    vpc_id = aws_vpc.sfvpc.id
  
}


resource "aws_vpc_security_group_ingress_rule" "allow_sf_ports" {
    for_each = toset(["15000", "15777", "7777"])
    security_group_id = aws_security_group.sf_instance_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = each.key
    ip_protocol       = "udp"
    to_port           = each.key
}

variable "home_ip" {
    type = string

}

resource "aws_vpc_security_group_ingress_rule" "allow_home" {
    security_group_id = aws_security_group.sf_instance_sg.id
    cidr_ipv4 = var.home_ip
    ip_protocol = -1

}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
    security_group_id = aws_security_group.sf_instance_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = -1

}