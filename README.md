# docker-terraform

[![github-actions](https://github.com/theohbrothers/docker-terraform/actions/workflows/ci-master-pr.yml/badge.svg?branch=master)](https://github.com/theohbrothers/docker-terraform/actions/workflows/ci-master-pr.yml)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-terraform?style=flat-square)](https://github.com/theohbrothers/docker-terraform/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-terraform/latest)](https://hub.docker.com/r/theohbrothers/docker-terraform)

Dockerized [terraform](https://github.com/hashicorp/terraform) with useful tools.

The base image is `alpine`. The image is not the closed-source [`hashicorp/terraform` image on DockerHub](https://hub.docker.com/r/hashicorp/terraform), see [here](https://github.com/hashicorp/terraform/blob/v1.0.0/Dockerfile).

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:1.9.4`, `:latest` | [View](variants/1.9.4) |
| `:1.9.4-jq-sops-ssh` | [View](variants/1.9.4-jq-sops-ssh) |
| `:1.9.4-jq-libvirt-sops-ssh` | [View](variants/1.9.4-jq-libvirt-sops-ssh) |
| `:1.8.5` | [View](variants/1.8.5) |
| `:1.8.5-jq-sops-ssh` | [View](variants/1.8.5-jq-sops-ssh) |
| `:1.8.5-jq-libvirt-sops-ssh` | [View](variants/1.8.5-jq-libvirt-sops-ssh) |
| `:1.7.5` | [View](variants/1.7.5) |
| `:1.7.5-jq-sops-ssh` | [View](variants/1.7.5-jq-sops-ssh) |
| `:1.7.5-jq-libvirt-sops-ssh` | [View](variants/1.7.5-jq-libvirt-sops-ssh) |
| `:1.6.6` | [View](variants/1.6.6) |
| `:1.6.6-jq-sops-ssh` | [View](variants/1.6.6-jq-sops-ssh) |
| `:1.6.6-jq-libvirt-sops-ssh` | [View](variants/1.6.6-jq-libvirt-sops-ssh) |
| `:1.5.7` | [View](variants/1.5.7) |
| `:1.5.7-jq-sops-ssh` | [View](variants/1.5.7-jq-sops-ssh) |
| `:1.5.7-jq-libvirt-sops-ssh` | [View](variants/1.5.7-jq-libvirt-sops-ssh) |
| `:1.4.7` | [View](variants/1.4.7) |
| `:1.4.7-jq-sops-ssh` | [View](variants/1.4.7-jq-sops-ssh) |
| `:1.4.7-jq-libvirt-sops-ssh` | [View](variants/1.4.7-jq-libvirt-sops-ssh) |
| `:1.3.10` | [View](variants/1.3.10) |
| `:1.3.10-jq-sops-ssh` | [View](variants/1.3.10-jq-sops-ssh) |
| `:1.3.10-jq-libvirt-sops-ssh` | [View](variants/1.3.10-jq-libvirt-sops-ssh) |
| `:1.2.9` | [View](variants/1.2.9) |
| `:1.2.9-jq-sops-ssh` | [View](variants/1.2.9-jq-sops-ssh) |
| `:1.2.9-jq-libvirt-sops-ssh` | [View](variants/1.2.9-jq-libvirt-sops-ssh) |
| `:1.1.9` | [View](variants/1.1.9) |
| `:1.1.9-jq-sops-ssh` | [View](variants/1.1.9-jq-sops-ssh) |
| `:1.1.9-jq-libvirt-sops-ssh` | [View](variants/1.1.9-jq-libvirt-sops-ssh) |
| `:1.0.11` | [View](variants/1.0.11) |
| `:1.0.11-jq-sops-ssh` | [View](variants/1.0.11-jq-sops-ssh) |
| `:1.0.11-jq-libvirt-sops-ssh` | [View](variants/1.0.11-jq-libvirt-sops-ssh) |
| `:0.15.5` | [View](variants/0.15.5) |
| `:0.15.5-jq-sops-ssh` | [View](variants/0.15.5-jq-sops-ssh) |
| `:0.15.5-jq-libvirt-sops-ssh` | [View](variants/0.15.5-jq-libvirt-sops-ssh) |
| `:0.14.11` | [View](variants/0.14.11) |
| `:0.14.11-jq-sops-ssh` | [View](variants/0.14.11-jq-sops-ssh) |
| `:0.14.11-jq-libvirt-sops-ssh` | [View](variants/0.14.11-jq-libvirt-sops-ssh) |
| `:0.13.7` | [View](variants/0.13.7) |
| `:0.13.7-jq-sops-ssh` | [View](variants/0.13.7-jq-sops-ssh) |
| `:0.13.7-jq-libvirt-sops-ssh` | [View](variants/0.13.7-jq-libvirt-sops-ssh) |
| `:0.12.31` | [View](variants/0.12.31) |
| `:0.12.31-jq-sops-ssh` | [View](variants/0.12.31-jq-sops-ssh) |
| `:0.12.31-jq-libvirt-sops-ssh` | [View](variants/0.12.31-jq-libvirt-sops-ssh) |
| `:0.11.15` | [View](variants/0.11.15) |
| `:0.11.15-jq-sops-ssh` | [View](variants/0.11.15-jq-sops-ssh) |
| `:0.11.15-jq-libvirt-sops-ssh` | [View](variants/0.11.15-jq-libvirt-sops-ssh) |
| `:0.10.8` | [View](variants/0.10.8) |
| `:0.10.8-jq-sops-ssh` | [View](variants/0.10.8-jq-sops-ssh) |
| `:0.10.8-jq-libvirt-sops-ssh` | [View](variants/0.10.8-jq-libvirt-sops-ssh) |
| `:0.9.11` | [View](variants/0.9.11) |
| `:0.9.11-jq-sops-ssh` | [View](variants/0.9.11-jq-sops-ssh) |
| `:0.9.11-jq-libvirt-sops-ssh` | [View](variants/0.9.11-jq-libvirt-sops-ssh) |
| `:0.8.8` | [View](variants/0.8.8) |
| `:0.8.8-jq-sops-ssh` | [View](variants/0.8.8-jq-sops-ssh) |
| `:0.8.8-jq-libvirt-sops-ssh` | [View](variants/0.8.8-jq-libvirt-sops-ssh) |

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
