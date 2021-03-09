resource "aws_iam_role" "mkaesz_tfc_agent_instance_role" {
  name = "mkaesz_tfc_agent_instance_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      owner = "mkaesz"
  }
}

resource "aws_iam_instance_profile" "mkaesz_instance_profile" {
  name = "mkaesz_instance_profile"
  role = aws_iam_role.mkaesz_tfc_agent_instance_role.name
}

resource "aws_iam_role_policy" "mkaesz_instance_policy" {
  name = "mkaesz_instance_policy"
  role = aws_iam_role.mkaesz_tfc_agent_instance_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_instance" "mkaesz_role_test" {
  ami = "ami-073a8e22592a4a925" #Centos8-EU-Central-1
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.mkaesz_instance_profile.name
  key_name = "mkaesz"

  tags = {
    Name = "mkaesz"
  }
}
