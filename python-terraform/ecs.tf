resource "aws_ecs_cluster" "main" {
  name = "app-cluster"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.example.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.example.name
      }
    }
  }
}

resource "aws_kms_key" "example" {
  description             = "example"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "example" {
  name = "example"
}

resource "aws_cloudwatch_log_group" "app-container-logs" {
  name = "app-container-logs"
}


resource "aws_cloudwatch_log_group" "redis-container-logs" {
  name = "redis-container-logs"
}

#########################################################################
data "template_file" "app-template" {
  template = file("./containers-definitions/app.json.tpl")

  vars = {
    app_name         = "${var.app_container_name}"
    app_image        = "${var.app_image}"
    app_port         = "${var.app_port}"
    fargate_cpu      = "${var.fargate_cpu}"
    fargate_memory   = "${var.fargate_memory}"
    aws_region       = "${var.aws_region}"
    REDIS_HOST       = "${var.redis_host}"
    REDIS_PORT       = "${var.redis_port}"
    cloudwatch_group = aws_cloudwatch_log_group.app-container-logs.name
    task_role        = aws_iam_role.ecs_task_execution_role.arn
  }
}

data "template_file" "redis-template" {
  template = file("./containers-definitions/redis.json.tpl")

  vars = {
    app_name         = "${var.redis_container_name}"
    app_image        = "${var.redis_image}"
    app_port         = "${var.redis_port}"
    fargate_cpu      = "${var.fargate_cpu}"
    fargate_memory   = "${var.fargate_memory}"
    aws_region       = "${var.aws_region}"
    cloudwatch_group = aws_cloudwatch_log_group.redis-container-logs.name
    task_role        = aws_iam_role.ecs_task_execution_role.arn
  }
}
##########################################################################

resource "aws_ecs_task_definition" "app" {
  family                   = "python-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.app-template.rendered
}

resource "aws_ecs_task_definition" "redis" {
  family                   = "redis-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.redis-template.rendered
  ## logs 
}

###########################################################################

resource "aws_ecs_service" "main-app" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs-app-sg.id]
    subnets         = aws_subnet.private.*.id
    # assign_public_ip = no
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "python-app"
    container_port   = var.app_port
  }

  service_registries {
    registry_arn = aws_service_discovery_service.app-service.arn
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

resource "aws_ecs_service" "main-redis" {
  name            = "redis-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.redis.arn
  desired_count   = var.redis_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs-redis-sg.id]
    subnets         = aws_subnet.private.*.id
    # assign_public_ip = no
  }

  service_registries {
    registry_arn = aws_service_discovery_service.redis-service.arn
  }

}