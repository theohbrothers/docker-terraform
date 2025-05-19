FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

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
