FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_386.zip"; \
            SHA256=190dec902043ea3ef7889c6e5ba5d9c96f6e607039c4340a66f289c945a01320; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip"; \
            SHA256=9cf727b4d6bd2d4d2908f08bd282f9e4809d6c3071c3b8ebe53558bee6dc913b; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_arm.zip"; \
            SHA256=6a6436ce51a72317bd3f72fddb06e2f7ee19bd4f1a39d10e64fefd0491722e35; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_arm.zip"; \
            SHA256=6a6436ce51a72317bd3f72fddb06e2f7ee19bd4f1a39d10e64fefd0491722e35; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_arm64.zip"; \
            SHA256=adb3206971bc73fd37c7b50399ef79fe5610b03d3f2d1783d91e119422a113fd; \
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
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
