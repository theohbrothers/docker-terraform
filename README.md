# docker-terraform

[![github-actions](https://github.com/theohbrothers/docker-terraform/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-terraform/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-terraform?style=flat-square)](https://github.com/theohbrothers/docker-terraform/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-terraform/latest)](https://hub.docker.com/r/theohbrothers/docker-terraform)

Dockerized `terraform` with useful tools.

The base image is `alpine`, and not the closed-source [`hashicorp/terraform` image on DockerHub](https://hub.docker.com/r/hashicorp/terraform), see [here](https://github.com/hashicorp/terraform/blob/v1.0.0/Dockerfile).

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:v1.5.7`, `:latest` | [View](variants/v1.5.7) |
| `:v1.5.7-jq-sops-ssh` | [View](variants/v1.5.7-jq-sops-ssh) |
| `:v1.5.7-jq-libvirt-sops-ssh` | [View](variants/v1.5.7-jq-libvirt-sops-ssh) |
| `:v1.4.7` | [View](variants/v1.4.7) |
| `:v1.4.7-jq-sops-ssh` | [View](variants/v1.4.7-jq-sops-ssh) |
| `:v1.4.7-jq-libvirt-sops-ssh` | [View](variants/v1.4.7-jq-libvirt-sops-ssh) |
| `:v1.3.10` | [View](variants/v1.3.10) |
| `:v1.3.10-jq-sops-ssh` | [View](variants/v1.3.10-jq-sops-ssh) |
| `:v1.3.10-jq-libvirt-sops-ssh` | [View](variants/v1.3.10-jq-libvirt-sops-ssh) |
| `:v1.2.9` | [View](variants/v1.2.9) |
| `:v1.2.9-jq-sops-ssh` | [View](variants/v1.2.9-jq-sops-ssh) |
| `:v1.2.9-jq-libvirt-sops-ssh` | [View](variants/v1.2.9-jq-libvirt-sops-ssh) |
| `:v1.1.9` | [View](variants/v1.1.9) |
| `:v1.1.9-jq-sops-ssh` | [View](variants/v1.1.9-jq-sops-ssh) |
| `:v1.1.9-jq-libvirt-sops-ssh` | [View](variants/v1.1.9-jq-libvirt-sops-ssh) |
| `:v1.0.11` | [View](variants/v1.0.11) |
| `:v1.0.11-jq-sops-ssh` | [View](variants/v1.0.11-jq-sops-ssh) |
| `:v1.0.11-jq-libvirt-sops-ssh` | [View](variants/v1.0.11-jq-libvirt-sops-ssh) |
| `:v0.15.5` | [View](variants/v0.15.5) |
| `:v0.15.5-jq-sops-ssh` | [View](variants/v0.15.5-jq-sops-ssh) |
| `:v0.15.5-jq-libvirt-sops-ssh` | [View](variants/v0.15.5-jq-libvirt-sops-ssh) |
| `:v0.14.11` | [View](variants/v0.14.11) |
| `:v0.14.11-jq-sops-ssh` | [View](variants/v0.14.11-jq-sops-ssh) |
| `:v0.14.11-jq-libvirt-sops-ssh` | [View](variants/v0.14.11-jq-libvirt-sops-ssh) |
| `:v0.13.7` | [View](variants/v0.13.7) |
| `:v0.13.7-jq-sops-ssh` | [View](variants/v0.13.7-jq-sops-ssh) |
| `:v0.13.7-jq-libvirt-sops-ssh` | [View](variants/v0.13.7-jq-libvirt-sops-ssh) |
| `:v0.12.31` | [View](variants/v0.12.31) |
| `:v0.12.31-jq-sops-ssh` | [View](variants/v0.12.31-jq-sops-ssh) |
| `:v0.12.31-jq-libvirt-sops-ssh` | [View](variants/v0.12.31-jq-libvirt-sops-ssh) |
| `:v0.11.15` | [View](variants/v0.11.15) |
| `:v0.11.15-jq-sops-ssh` | [View](variants/v0.11.15-jq-sops-ssh) |
| `:v0.11.15-jq-libvirt-sops-ssh` | [View](variants/v0.11.15-jq-libvirt-sops-ssh) |
| `:v0.10.8` | [View](variants/v0.10.8) |
| `:v0.10.8-jq-sops-ssh` | [View](variants/v0.10.8-jq-sops-ssh) |
| `:v0.10.8-jq-libvirt-sops-ssh` | [View](variants/v0.10.8-jq-libvirt-sops-ssh) |
| `:v0.9.11` | [View](variants/v0.9.11) |
| `:v0.9.11-jq-sops-ssh` | [View](variants/v0.9.11-jq-sops-ssh) |
| `:v0.9.11-jq-libvirt-sops-ssh` | [View](variants/v0.9.11-jq-libvirt-sops-ssh) |
| `:v0.8.8` | [View](variants/v0.8.8) |
| `:v0.8.8-jq-sops-ssh` | [View](variants/v0.8.8-jq-sops-ssh) |
| `:v0.8.8-jq-libvirt-sops-ssh` | [View](variants/v0.8.8-jq-libvirt-sops-ssh) |

## Development

Requires Windows `powershell` or [`pwsh`](https://github.com/PowerShell/PowerShell).

```powershell
# Install Generate-DockerImageVariants module: https://github.com/theohbrothers/Generate-DockerImageVariants
Install-Module -Name Generate-DockerImageVariants -Repository PSGallery -Scope CurrentUser -Force -Verbose

# Edit ./generate templates

# Generate the variants
Generate-DockerImageVariants .
```

### Variant versions

[versions.json](generate/definitions/versions.json) contains a list of [Semver](https://semver.org/) versions, one per line.

To update versions in `versions.json`:

```powershell
./Update-Versions.ps1
```

To update versions in `versions.json`, and open a PR for each changed version, and merge successful PRs one after another (to prevent merge conflicts), and finally create a tagged release and close milestone:

```powershell
$env:GITHUB_TOKEN = 'xxx'
./Update-Versions.ps1 -PR -AutoMergeQueue -AutoRelease
```

To perform a dry run, use `-WhatIf`.
