FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.15.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_386.zip"; \
            SHA256=0155d6844ae554021f8ca58b57f1e6dda7d88b6cf1d02113f3a3480e178c46b9; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_amd64.zip"; \
            SHA256=3b144499e08c245a8039027eb2b84c0495e119f57d79e8fb605864bb48897a7d; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_arm.zip"; \
            SHA256=3122e7ac6353d488d766ac84379139e3d14f564fbe61f4b069f7584ca9c29e01; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_arm.zip"; \
            SHA256=3122e7ac6353d488d766ac84379139e3d14f564fbe61f4b069f7584ca9c29e01; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_arm64.zip"; \
            SHA256=bc5a9d734010e55fb374a4cab9eb0539139d34fd84f58d2242573f275f67fc13; \
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
