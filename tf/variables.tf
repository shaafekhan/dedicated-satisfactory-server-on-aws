
variable "home_ip" {
    description = "test"
    type = string
    nullable = false

}

output "test" {
    value = var.home_ip
}