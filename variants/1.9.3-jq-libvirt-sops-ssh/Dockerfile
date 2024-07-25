FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.3/terraform_1.9.3_linux_386.zip"; \
            SHA256=d67a8890bdbcda4dc23c1a053d021697cd7b4ce8921250563427adae7f2b4c2f; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.3/terraform_1.9.3_linux_amd64.zip"; \
            SHA256=e52520cf6d677155e69a8fcfe64054891f4d991802b0d36d4c8b670d60a7e899; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.3/terraform_1.9.3_linux_arm.zip"; \
            SHA256=0d3cbbfc97bc2cb3bf08cdb9dbabc17d8e2dabb0aedf60d752c51f14d3501ce2; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.3/terraform_1.9.3_linux_arm.zip"; \
            SHA256=0d3cbbfc97bc2cb3bf08cdb9dbabc17d8e2dabb0aedf60d752c51f14d3501ce2; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.3/terraform_1.9.3_linux_arm64.zip"; \
            SHA256=193ce269aafd5c44f359cd73a75c5cc7aaab924eb5c3601784c1873575828ec7; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=terraform.zip; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    unzip "$FILE" terraform; \
    mkdir -pv /usr/local/bin; \
    mv -v terraform /usr/local/bin/terraform; \
    chmod +x /usr/local/bin/terraform; \
    CHECKPOINT_DISABLE=1 terraform version; \
    :

RUN apk add --no-cache ca-certificates

RUN apk add --no-cache jq

RUN apk add --no-cache libvirt-client

RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
