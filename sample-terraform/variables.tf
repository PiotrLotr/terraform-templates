
# Please pass the bcuket name

variable "prefix" {
  type        = string
  description = "Prefix for intro task resources"
  default     = "prefix"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of intro task bucket"
  default     = "task-bucket-123"
}

