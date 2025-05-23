FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.10.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.10.0/terraform_1.10.0_linux_386.zip"; \
            SHA256=8af8eb3315ecade87ec6cb04dd16a5b6ebefd7bf7058b8e8db7422c1c9500108; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.10.0/terraform_1.10.0_linux_amd64.zip"; \
            SHA256=4b05f4848d365597cf7ac5b59334c62a16b3bb7b524586578ee45ba823b6758b; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.10.0/terraform_1.10.0_linux_arm.zip"; \
            SHA256=8209739371bad76287e04aedd2a3b1b6bcf5c16ae9ba8adbb93dc3d7346df9f1; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.10.0/terraform_1.10.0_linux_arm.zip"; \
            SHA256=8209739371bad76287e04aedd2a3b1b6bcf5c16ae9ba8adbb93dc3d7346df9f1; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.10.0/terraform_1.10.0_linux_arm64.zip"; \
            SHA256=e12fad357bcff9537e904a7821529206c2c8fb48f700b670c25d6deddbb65d05; \
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
