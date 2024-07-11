FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.2/terraform_1.9.2_linux_386.zip"; \
            SHA256=2bbe23adeb5331d8ce65d6c28faac02dca03d33881912bf4ad93c467da3474d2; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.2/terraform_1.9.2_linux_amd64.zip"; \
            SHA256=d5f5aaba0f8ebff88ef0b23935872e154e2abf3172596261be834605ba3ba714; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.2/terraform_1.9.2_linux_arm.zip"; \
            SHA256=416990887ce03bdc518fd689f2640c0f34da2a12189595ca38db5ede371f4a1a; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.2/terraform_1.9.2_linux_arm.zip"; \
            SHA256=416990887ce03bdc518fd689f2640c0f34da2a12189595ca38db5ede371f4a1a; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.2/terraform_1.9.2_linux_arm64.zip"; \
            SHA256=901821024261b851c46e2060d8849750a93dfe64bf8bcb85839f13325945f889; \
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
