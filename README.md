# docker-terraform

[![github-actions](https://github.com/theohbrothers/docker-terraform/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-terraform/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-terraform?style=flat-square)](https://github.com/theohbrothers/docker-terraform/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-terraform/latest)](https://hub.docker.com/r/theohbrothers/docker-terraform)

Dockerized `terraform` with useful tools.

The base image is `alpine`, and not the closed-source [`hashicorp/terraform` image on DockerHub](https://hub.docker.com/r/hashicorp/terraform), see [here](https://github.com/hashicorp/terraform/blob/v1.0.0/Dockerfile).

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:v1.0.6-alpine-edge` | [View](variants/v1.0.6-alpine-edge ) |
| `:v1.0.6-sops-ssh-alpine-edge`, `:latest` | [View](variants/v1.0.6-sops-ssh-alpine-edge ) |
| `:v0.14.9-alpine-3.14` | [View](variants/v0.14.9-alpine-3.14 ) |
| `:v0.14.9-sops-ssh-alpine-3.14` | [View](variants/v0.14.9-sops-ssh-alpine-3.14 ) |
| `:v0.14.4-alpine-3.13` | [View](variants/v0.14.4-alpine-3.13 ) |
| `:v0.14.4-sops-ssh-alpine-3.13` | [View](variants/v0.14.4-sops-ssh-alpine-3.13 ) |
| `:v0.12.25-alpine-3.12` | [View](variants/v0.12.25-alpine-3.12 ) |
| `:v0.12.25-sops-ssh-alpine-3.12` | [View](variants/v0.12.25-sops-ssh-alpine-3.12 ) |
| `:v0.12.17-alpine-3.11` | [View](variants/v0.12.17-alpine-3.11 ) |
| `:v0.12.17-sops-ssh-alpine-3.11` | [View](variants/v0.12.17-sops-ssh-alpine-3.11 ) |
| `:v0.12.6-alpine-3.10` | [View](variants/v0.12.6-alpine-3.10 ) |
| `:v0.12.6-sops-ssh-alpine-3.10` | [View](variants/v0.12.6-sops-ssh-alpine-3.10 ) |
| `:v0.11.8-alpine-3.9` | [View](variants/v0.11.8-alpine-3.9 ) |
| `:v0.11.8-sops-ssh-alpine-3.9` | [View](variants/v0.11.8-sops-ssh-alpine-3.9 ) |
| `:v0.11.7-alpine-3.8` | [View](variants/v0.11.7-alpine-3.8 ) |
| `:v0.11.7-sops-ssh-alpine-3.8` | [View](variants/v0.11.7-sops-ssh-alpine-3.8 ) |
| `:v0.11.0-alpine-3.7` | [View](variants/v0.11.0-alpine-3.7 ) |
| `:v0.11.0-sops-ssh-alpine-3.7` | [View](variants/v0.11.0-sops-ssh-alpine-3.7 ) |
| `:v0.9.5-alpine-3.6` | [View](variants/v0.9.5-alpine-3.6 ) |
| `:v0.9.5-sops-ssh-alpine-3.6` | [View](variants/v0.9.5-sops-ssh-alpine-3.6 ) |
| `:v0.8.1-alpine-3.5` | [View](variants/v0.8.1-alpine-3.5 ) |
| `:v0.8.1-sops-ssh-alpine-3.5` | [View](variants/v0.8.1-sops-ssh-alpine-3.5 ) |
