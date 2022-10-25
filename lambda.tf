module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "my-lambda-package"
  description   = "assignment"
  handler       = "index.lambda_handler"
  runtime       = "python3.9"

  create_package         = false
  local_existing_package = "./lambda_python.zip"

  ignore_source_code_hash = true

  create_async_event_config = true
  attach_async_event_policy = true

  destination_on_success = aws_sns_topic.lambda-sns.arn 
}

resource "aws_sns_topic" "lambda-sns" {
  name = "lambda-sns"
}

resource "aws_sns_topic_subscription" "lambda-sns" {
  topic_arn = aws_sns_topic.lambda-sns.arn
  protocol  = "email"
  endpoint  = "gilad437@gmail.com"
}