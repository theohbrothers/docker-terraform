FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.12.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_linux_386.zip"; \
            SHA256=044a4e8591d95d711d3918956c7d267060131e526d6da93f5d62099d8714b1d3; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_linux_amd64.zip"; \
            SHA256=dcaf8ba801660a431a6769ec44ba53b66c1ad44637512ef3961f7ffe4397ef7c; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_linux_arm.zip"; \
            SHA256=552a2dba27b8da9c0f59342a854c5b0e77250362c83964b84a8d0e2defb59ef2; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_linux_arm.zip"; \
            SHA256=552a2dba27b8da9c0f59342a854c5b0e77250362c83964b84a8d0e2defb59ef2; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_linux_arm64.zip"; \
            SHA256=70e8c1776646f2af83ccad6113b8bb4768e6f7dc65335ae11ffd095eca3b0d4c; \
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
