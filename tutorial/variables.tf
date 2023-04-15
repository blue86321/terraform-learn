variable "access_key" {
  description = "AWS admin access key"
  # Set default value
  # default = "test"

  # type: string / number / boolean / list ...
  # Source: https://developer.hashicorp.com/terraform/language/expressions/types
  type = string
}

variable "secret_key" {
  description = "AWS admin secret key"
}
