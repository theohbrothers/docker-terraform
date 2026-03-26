FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.8; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.8/terraform_1.14.8_linux_386.zip"; \
            SHA256=38b3ca568f5a9d30e7330ca88d088eebe71fb13888ad38f6e00e99985b559452; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.8/terraform_1.14.8_linux_amd64.zip"; \
            SHA256=56a5d12f47cbc1c6bedb8f5426ae7d5df984d1929572c24b56f4c82e9f9bf709; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.8/terraform_1.14.8_linux_arm.zip"; \
            SHA256=4bed85ecc7f3d73826920ac5b57c02efeb04fa3b72f16d0b01921a94fd7252dc; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.8/terraform_1.14.8_linux_arm.zip"; \
            SHA256=4bed85ecc7f3d73826920ac5b57c02efeb04fa3b72f16d0b01921a94fd7252dc; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.8/terraform_1.14.8_linux_arm64.zip"; \
            SHA256=c953171cde6b25ca0448c3b29a90d2f46c0310121e18742ec8f89631768e770c; \
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
