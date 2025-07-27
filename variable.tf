# variable "ec2_root_storage_size" {
#   default = 8
#   type    = number
# }

# variable "ec2_ami_id" {
#     default =   "ami-01f23391a59163da9"
#     type = string
# }

variable env {
  default = "prod"
  description = "Production environment"
}