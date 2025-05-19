FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.8; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_386.zip"; \
            SHA256=aa85bb2e0c68f2ee148d1ea854ee0aa78086017cbda9058371be8be2f4c18d10; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip"; \
            SHA256=186e0145f5e5f2eb97cbd785bc78f21bae4ef15119349f6ad4fa535b83b10df8; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_arm.zip"; \
            SHA256=cb6db8471e361bb9ad6bbd43d9c780d37208e6dbe416900fdc8999af9e459b77; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_arm.zip"; \
            SHA256=cb6db8471e361bb9ad6bbd43d9c780d37208e6dbe416900fdc8999af9e459b77; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_arm64.zip"; \
            SHA256=f85868798834558239f6148834884008f2722548f84034c9b0f62934b2d73ebb; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=terraform.zip; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    unzip "$FILE" -d extract; \
    mkdir -pv /usr/local/bin; \
    BIN=$( find extract -type f -name "terraform" | head -n1 ); \
    mv -v "$BIN" /usr/local/bin/terraform; \
    chmod +x /usr/local/bin/terraform; \
    CHECKPOINT_DISABLE=1 terraform version; \
    rm -rf extract; \
    rm -f "$FILE"; \
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
