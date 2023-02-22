resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/24"
    tags {
        Name = VPC00
    }
}

resource "aws_vpc" "main1" {
    cidr_block = "11.0.0.0/24"
    tags {
        Name = VPC01
    }
}

resource "aws_vpc" "main2" {
    cidr_block = "12.0.0.0/24"
    tags {
        Name = VPC02
    }
}

resource "aws_vpc" "main3" {
    cidr_block = "13.0.0.0/24"
    tags {
        Name = VPC03
    }
}

resource "aws_vpc" "main4" {
    cidr_block = "14.0.0.0/24"
    tags {
        Name = VPC04
    }
}

resource "aws_vpc" "main5" {
    cidr_block = "15.0.0.0/24"
    tags {
        Name = VPC05
    }
}