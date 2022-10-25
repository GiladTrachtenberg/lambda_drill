module "iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "email"
  path        = "/"
  description = "email polic"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Subscribe*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:sns:eu-central-1:264574450100:user-updates-topic"
    }
  ]
}
EOF
}

module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::264574450100:root"
  ]

  create_role = true
  role_name         = "lambda-s3-trigger"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::264574450100:policy/email"
  ]
  number_of_custom_role_policy_arns = 3
}

