resource "aws_sns_topic" "async" {
  name = "async"
}

resource "aws_sns_topic_subscription" "async" {
  topic_arn = aws_sns_topic.async.arn
  protocol  = "email"
  endpoint  = "gilad437@gmail.com"
}