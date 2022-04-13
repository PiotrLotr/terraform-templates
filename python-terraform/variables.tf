# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "eu-central-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default     = "myEcsAutoScaleRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "3"
}

############################################################

variable "app_container_name" {
  default = "python-app"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

# TODO: Hardoced var alarm in default
variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "251865263936.dkr.ecr.eu-central-1.amazonaws.com/app-dev:latest"
}

#############################################################

variable "redis_container_name" {
  default = "redis"
}

variable "redis_host" {
  description = "Redis hostname"
  default     = "redis-service.local"
}

variable "redis_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 6379
}


variable "redis_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "redis:alpine"
}

variable "redis_count" {
  description = "Number of docker containers to run"
  default     = 1
}

#################################################################

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

