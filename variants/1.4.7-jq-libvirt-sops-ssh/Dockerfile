FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.4.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.4.7/terraform_1.4.7_linux_386.zip"; \
            SHA256=8dab06a286ab399288950bd144525f8be2527975cfbc9a695c3faf0fc162d02c; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.4.7/terraform_1.4.7_linux_amd64.zip"; \
            SHA256=247c75658065b8691e19455f79969f583029f905a37026489f22c56a8830b8b2; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.4.7/terraform_1.4.7_linux_arm.zip"; \
            SHA256=5f258d7deb2bf0c6bd55af8e9d88519b78ca91f66e13c7dda9fbe3591d842604; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.4.7/terraform_1.4.7_linux_arm.zip"; \
            SHA256=5f258d7deb2bf0c6bd55af8e9d88519b78ca91f66e13c7dda9fbe3591d842604; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.4.7/terraform_1.4.7_linux_arm64.zip"; \
            SHA256=5f8a31bbb391b2044e992975290d8fb1bf4f7996c84a40c91ea521b9cb0b5791; \
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
