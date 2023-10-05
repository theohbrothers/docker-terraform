FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.6.0; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_386.zip; \
            SHA256=cec080eeaee5f15caf4e3162315975b29ffbc49553f65f121e903cda93264016; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip; \
            SHA256=0ddc3f21786026e1f8522ba0f5c6ed27a3c8cc56bfac91e342c1f578f8af44a8; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_arm.zip; \
            SHA256=92775f32d6266807685a03c787711377aaebaae115afc18f0c0440e2e7db5fea; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_arm.zip; \
            SHA256=92775f32d6266807685a03c787711377aaebaae115afc18f0c0440e2e7db5fea; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_arm64.zip; \
            SHA256=413006af67285f158df9e7e2ce1faf4460fd68aa7de612f550aa0e8d70d62e60; \
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
