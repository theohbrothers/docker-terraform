FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_386.zip"; \
            SHA256=6cd1ce0fda9c784224e5a31b94a4114015fdd869c1912cae51f49de03e42155e; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip"; \
            SHA256=ab1358e73a81096bbe04201ef403a32e0765c5f6e360692d170d32d0889a4871; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_arm.zip"; \
            SHA256=94d3fb0bd6df8de2cfb24781344036a15e9de8ee148b3cf1bc870c9ea69c88d8; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_arm.zip"; \
            SHA256=94d3fb0bd6df8de2cfb24781344036a15e9de8ee148b3cf1bc870c9ea69c88d8; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_arm64.zip"; \
            SHA256=f5c0a49b482c008a6afd2248c08ca919e599c1154a850ff94809f4a85c86eb3b; \
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
