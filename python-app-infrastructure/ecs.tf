resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster-for-python-app"
}

resource "aws_ecs_service" "ecs-service" {
  name            = "python-app"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.service-task.arn
  desired_count   = 2

  deployment_controller {
    type = "ECS"
  }
}
