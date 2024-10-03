FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_386.zip"; \
            SHA256=ef13210f44ef4497cfae3d2226162ebd1078c383a8d0a22126c6862a4cf54b2f; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip"; \
            SHA256=76a77ed7e785ef354b7f565abaa990e3e7b5232d3ec4afb87e0f5a413fcbdad1; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_arm.zip"; \
            SHA256=14f0a10f9fed64a22581c32b7e0ad675065f8470f32cef6d5be29c29928dcd3b; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_arm.zip"; \
            SHA256=14f0a10f9fed64a22581c32b7e0ad675065f8470f32cef6d5be29c29928dcd3b; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_arm64.zip"; \
            SHA256=8fc6f1172ff026abc4f0c399996fa454e605bfc1df6793af82d922a66b5c41f8; \
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
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
