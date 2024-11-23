variable "aws_region" {  
  default = "eu-north-1"  
}  

variable "ecr_repository_name" {  
  default = "dev-fplarache-smartlib-notification-repo"  
}  

variable "ecs_cluster_name" {  
  default = "dev-fplarache-smartlib-notification-fgcluster"  
}  

variable "ecs_task_family" {  
  default = "dev-fplarache-smartlib-notification-td"  
}  

variable "ecs_service_name" {  
  default = "dev-fplarache-smartlib-notification-fgservice"  
}  

variable "subnet_ids" {  
  type = list(string)  
}