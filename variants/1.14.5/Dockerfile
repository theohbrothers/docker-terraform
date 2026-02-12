FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.5/terraform_1.14.5_linux_386.zip"; \
            SHA256=7efe66c5c49d77c8d2dd1ef2d1c539b456a223473d96258de0a6da07c7cffe04; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.5/terraform_1.14.5_linux_amd64.zip"; \
            SHA256=ac21c2b9dcd115711f540cbd27ead0596bb4288a917cb56dfa9b25edb3eb6280; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.5/terraform_1.14.5_linux_arm.zip"; \
            SHA256=5fe9b93bf93bca52ad20dc95114f269f3bf33b554d7eb5f515f8763f74dc2884; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.5/terraform_1.14.5_linux_arm.zip"; \
            SHA256=5fe9b93bf93bca52ad20dc95114f269f3bf33b554d7eb5f515f8763f74dc2884; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.5/terraform_1.14.5_linux_arm64.zip"; \
            SHA256=7dbd03721e8f933ba0426fc292d7a6549a61c0cb1c7c821729f6982c7bce4b05; \
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

CMD [ "terraform" ]
