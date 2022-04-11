
resource "aws_service_discovery_private_dns_namespace" "app" {
  name        = "app.terraform.local"
  description = "app"
  vpc         = aws_vpc.main.id
}

resource "aws_service_discovery_service" "app" {
  name = "app-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.app.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

################################################################

resource "aws_service_discovery_private_dns_namespace" "redis" {
  name        = "redis.terraform.local"
  description = "redis"
  vpc         = aws_vpc.main.id
}

resource "aws_service_discovery_service" "redis" {
  name = "redis-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.redis.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}