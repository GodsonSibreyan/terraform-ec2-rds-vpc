#######################
#  EC2 Role
####################

resource "aws_iam_instance_profile" "wp-ec2-profile" {
  name = "wp-ec2-profile"
  role = "${aws_iam_role.wp-ec2-role.name}"
}

resource "aws_iam_role" "wp-ec2-role" {
  name = "wp-ec2-role"
  path = "/"

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
}