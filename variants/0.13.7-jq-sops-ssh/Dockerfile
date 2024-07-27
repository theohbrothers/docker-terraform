FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.13.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_386.zip"; \
            SHA256=90df3c9e8a9facf93631c6d338b867db391b435a39a1ca0a02ae4908f01dc2ea; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_amd64.zip"; \
            SHA256=4a52886e019b4fdad2439da5ff43388bbcc6cce9784fde32c53dcd0e28ca9957; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_arm.zip"; \
            SHA256=9af803e215be58ed6cf89e9d22b826d7b3634bef70dc94abc13fdd2bd85b1f80; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_arm.zip"; \
            SHA256=9af803e215be58ed6cf89e9d22b826d7b3634bef70dc94abc13fdd2bd85b1f80; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_arm64.zip"; \
            SHA256=59b85b7b4b4b2939a4c05db905100dd8808f8df8b5a0e8a00a26e7dcf0c4a2be; \
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
