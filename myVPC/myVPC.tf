# variables
variable "myaccess_key" {}
variable "mysecret_key" {}
variable "myregion" {default = "us-east-2"}

# provider
provider "aws" {
access_key = "${var.myaccess_key}"
secret_key = "${var.mysecret_key}"
region = "${var.myregion}"
}


# resources
resource "aws_vpc" "myVPC" {
  cidr_block = "192.168.0.0/16"
  tags = {
    "Name" = "myVPC"
  }
}
resource "aws_subnet" "myPublicSubnet" {
    cidr_block = "192.168.1.0/24"
    vpc_id = aws_vpc.myVPC.id
    tags = {
      "Name" = "myPublicSubnet"
    }
  
}

resource "aws_route_table" "myPublicRoutingTable" {
    vpc_id = aws_vpc.myVPC.id
     tags = {
       "Name" = "myPublicRouteTable"
     }
}
# outputs
output "myVPCID" { value = aws_vpc.myVPC.id}