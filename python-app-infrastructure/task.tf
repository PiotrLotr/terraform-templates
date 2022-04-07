# resource "aws_ecs_task_definition" "app" {
#   family                   = "python-service-task"
#   execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = 1024
#   memory                   = 3096
#   container_definitions    = data.cb_app.rendered
# }