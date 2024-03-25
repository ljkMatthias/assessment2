# Configure the AWS provider
provider "aws" {
  region = "ap-southeast-1" # Replace with your desired AWS region
}

#IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

#IAM policy document
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Attach the necessary policies to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# Create the Lambda function
resource "aws_lambda_function" "example_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "getData-lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "assessment2.getData" 
  runtime          = "nodejs18.x"         
  source_code_hash = filebase64sha256("lambda_function.zip")
}