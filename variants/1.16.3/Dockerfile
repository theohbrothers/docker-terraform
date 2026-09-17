FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.3/terraform_1.16.3_linux_386.zip"; \
            SHA256=8a5888b667d5582709dfa09d436e8b0e75214fa2d1d5c8dde628f5816f3bb000; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.3/terraform_1.16.3_linux_amd64.zip"; \
            SHA256=093b6ae9a2228af5029c41606bc96eb583553528aad1bfe7e0b4d62fc91e25d8; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.3/terraform_1.16.3_linux_arm.zip"; \
            SHA256=2f50d88b99d7c0145cc1cf51adf92c46cbff6f211a7539c44bf3319baa50bb5f; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.3/terraform_1.16.3_linux_arm.zip"; \
            SHA256=2f50d88b99d7c0145cc1cf51adf92c46cbff6f211a7539c44bf3319baa50bb5f; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.3/terraform_1.16.3_linux_arm64.zip"; \
            SHA256=b6b293550af7a6a7ffd867a04900ce161db86ec9407b234a636c2adbae2ca9f0; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.3/terraform_1.16.3_linux_s390x.zip"; \
            SHA256=0f80a77711e43d81bcd75973d7490e9f0824971056265af4aefe81ed6b3084c2; \
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
