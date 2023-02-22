#----------------------------------------------------------------#
##                     Creating VPCs                            ##
#----------------------------------------------------------------#

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "VPC00"
    }
}

resource "aws_vpc" "main1" {
    cidr_block = "11.0.0.0/24"
    tags = {
        Name = "VPC01"
    }
}

resource "aws_vpc" "main2" {
    cidr_block = "12.0.0.0/24"
    tags = {
        Name = "VPC02"
    }
}

resource "aws_vpc" "main3" {
    cidr_block = "13.0.0.0/24"
    tags = {
        Name = "VPC03"
    }
}

resource "aws_vpc" "main4" {
    cidr_block = "14.0.0.0/24"
    tags = {
        Name = "VPC04"
    }
}

resource "aws_vpc" "main5" {
    cidr_block = "15.0.0.0/24"
    tags = {
        Name = "VPC05"
    }
}

#----------------------------------------------------------------#
##                        VPC Data                              ##
#----------------------------------------------------------------#

data "aws_vpc" "vpc0" {
  id = aws_vpc.main.vpc_id
}

data "aws_vpc" "vpc1" {
  id = aws_vpc.main1.vpc_id
}

data "aws_vpc" "vpc2" {
  id = aws_vpc.main2.vpc_id
}

data "aws_vpc" "vpc3" {
  id = aws_vpc.main3.vpc_id
}

data "aws_vpc" "vpc4" {
  id = aws_vpc.main4.vpc_id
}

data "aws_vpc" "vpc5" {
  id = aws_vpc.main5.vpc_id
}
#----------------------------------------------------------------#
##             Creating Flow Logs for VPCS 1,3,5                ##
#----------------------------------------------------------------#

resource "aws_flow_log" "flow_logs_example" {
  iam_role_arn = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type = "ALL"
  vpc_id = aws_vpc.main1.id
}

resource "aws_flow_log" "flow_logs_example" {
  iam_role_arn = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type = "ALL"
  vpc_id = aws_vpc.main3.id
}

resource "aws_flow_log" "flow_logs_example" {
  iam_role_arn = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type = "ALL"
  vpc_id = aws_vpc.main5.id
}

resource "aws_cloudwatch_log_group" "example" {
  name = "vpc_logs"
}

#----------------------------------------------------------------#
##             Creating Flow Log Role & Policy                  ##
#----------------------------------------------------------------#


resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = aws_iam_role.example.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}