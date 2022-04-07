resource "aws_ecs_task_definition" "service-task" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "251865263936.dkr.ecr.eu-central-1.amazonaws.com/app-dev:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}