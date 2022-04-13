[{
	"name": "${app_name}",
	"image": "${app_image}",
	"cpu": ${fargate_cpu},
	"memory": ${fargate_memory},
	"networkMode": "awsvpc",
	"taskRoleArn": "task_role",
	"portMappings": [{
		"containerPort": ${app_port},
		"hostPort": ${app_port}
	}],
	"logConfiguration": {
		"logDriver": "awslogs",
		"options": {
			"awslogs-group": "${cloudwatch_group}",
			"awslogs-region": "eu-central-1",
			"awslogs-stream-prefix": "streaming"
		}
	}
}]