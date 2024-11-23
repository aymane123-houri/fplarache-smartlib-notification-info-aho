variable "aws_region" {  
  default = "eu-north-1"  
}  

variable "ecr_repository_name" {  
  default = "dev-fplarache-smartlib-notification-repo-aho"  
}  

variable "ecs_cluster_name" {  
  default = "dev-fplarache-smartlib-notification-fgcluster-aho"  
}  

variable "ecs_task_family" {  
  default = "dev-fplarache-smartlib-notification-td-aho"  
}  

variable "ecs_service_name" {  
  default = "dev-fplarache-smartlib-notification-fgservice-aho"  
}  

variable "subnet_ids" {  
  type = list(string)  
}