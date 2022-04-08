[
  {
    "name": "redis",
    "image": "${redis_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${redis_port},
        "hostPort": ${redis_port}
      }
    ]
  }
]