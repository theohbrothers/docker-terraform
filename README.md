# docker-terraform

[![github-actions](https://github.com/theohbrothers/docker-terraform/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-terraform/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-terraform?style=flat-square)](https://github.com/theohbrothers/docker-terraform/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-terraform/latest)](https://hub.docker.com/r/theohbrothers/docker-terraform)

Dockerized `terraform` with useful tools.

The base image is `alpine`, and not the closed-source [`hashicorp/terraform` image on DockerHub](https://hub.docker.com/r/hashicorp/terraform), see [here](https://github.com/hashicorp/terraform/blob/v1.0.0/Dockerfile).

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:v1.4.6-jq-sops-ssh-alpine-3.18`, `:latest` | [View](variants/v1.4.6-jq-sops-ssh-alpine-3.18) |
| `:v1.4.6-jq-libvirt-sops-ssh-alpine-3.18` | [View](variants/v1.4.6-jq-libvirt-sops-ssh-alpine-3.18) |
| `:v1.3.4-jq-sops-ssh-alpine-3.17` | [View](variants/v1.3.4-jq-sops-ssh-alpine-3.17) |
| `:v1.3.4-jq-libvirt-sops-ssh-alpine-3.17` | [View](variants/v1.3.4-jq-libvirt-sops-ssh-alpine-3.17) |
| `:v1.2.0-jq-sops-ssh-alpine-3.16` | [View](variants/v1.2.0-jq-sops-ssh-alpine-3.16) |
| `:v1.0.11-jq-sops-ssh-alpine-3.15` | [View](variants/v1.0.11-jq-sops-ssh-alpine-3.15) |
| `:v0.14.9-jq-sops-ssh-alpine-3.14` | [View](variants/v0.14.9-jq-sops-ssh-alpine-3.14) |
| `:v0.14.4-jq-sops-ssh-alpine-3.13` | [View](variants/v0.14.4-jq-sops-ssh-alpine-3.13) |
| `:v0.12.25-jq-sops-ssh-alpine-3.12` | [View](variants/v0.12.25-jq-sops-ssh-alpine-3.12) |
| `:v0.12.17-jq-sops-ssh-alpine-3.11` | [View](variants/v0.12.17-jq-sops-ssh-alpine-3.11) |
| `:v0.12.6-jq-sops-ssh-alpine-3.10` | [View](variants/v0.12.6-jq-sops-ssh-alpine-3.10) |
| `:v0.11.8-jq-sops-ssh-alpine-3.9` | [View](variants/v0.11.8-jq-sops-ssh-alpine-3.9) |
| `:v0.11.7-jq-sops-ssh-alpine-3.8` | [View](variants/v0.11.7-jq-sops-ssh-alpine-3.8) |
| `:v0.11.0-jq-sops-ssh-alpine-3.7` | [View](variants/v0.11.0-jq-sops-ssh-alpine-3.7) |
| `:v0.9.5-jq-sops-ssh-alpine-3.6` | [View](variants/v0.9.5-jq-sops-ssh-alpine-3.6) |
| `:v0.8.1-jq-sops-ssh-alpine-3.5` | [View](variants/v0.8.1-jq-sops-ssh-alpine-3.5) |

## Development

Requires Windows `powershell` or [`pwsh`](https://github.com/PowerShell/PowerShell).

```powershell
# Install Generate-DockerImageVariants module: https://github.com/theohbrothers/Generate-DockerImageVariants
Install-Module -Name Generate-DockerImageVariants -Repository PSGallery -Scope CurrentUser -Force -Verbose

# Edit ./generate templates

# Generate the variants
Generate-DockerImageVariants .
```
