#Variables

variable "myaccess_key" {}
variable "mysecret_key" {}
variable "myregion" {default = "us-east-2"}


# Provider
provider "aws" {
  access_key = "${var.myaccess_key}"
  secret_key = "${var.mysecret_key}"
  region = "${var.myregion}"
}


# Resources
resource "aws_instance" "mywebserver" {
  ami = "ami-0a59f0e26c55590e9"
  instance_type = "t2.micro"
  key_name = "mykey22aug22"


connection {
  type = "ssh"
  user = "ubuntu"
  host = aws_instance.mywebserver.public_ip
  private_key = "${file("mykey22aug22.pem")}"
  agent = false
  timeout = "300"
}


provisioner "remote-exec" {
  
  inline = [
    "sudo apt-get update",
    "sudo apt-get install nginx -y"
    
  ]
}
   
}


# Outputs
output "myAwsInstanceID" { 
    value = aws_instance.mywebserver.id
}
