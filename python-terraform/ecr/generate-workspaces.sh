#!/bin/bash

terraform workspace new dev
terraform apply
terraform workspace new prod
terraform apply
