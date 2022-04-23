variable "aws_region" {
  description = "AWS region to launch servers."
  #default     = "us-east-1"
}

variable "env" {
  description = "Targeted Depolyment environment"
  #default     = "impl"
}

variable "aws_account_number" {
  default = "330810004472"
}

variable "aws_ecs_cluster_name" {
  description = "Target Amazon ECS Cluster Name"
  #default     = "Microservice-Cluster"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "microservice-artifact-impl-bucket-ab2d"
}

variable "role_arn" {
  description = "Role_arn"

}

variable "ProjectName" {
  description = "ProjectName"

}

variable "ConnectionArn" {
  description = "ConnectionArn"
  
}

variable "service_name" {
  
  
}