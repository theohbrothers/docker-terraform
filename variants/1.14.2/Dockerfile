FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.2/terraform_1.14.2_linux_386.zip"; \
            SHA256=38c920847f01713d7170b7a0d41aeb77bb985a1f23d31eaa31553903ac543541; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.2/terraform_1.14.2_linux_amd64.zip"; \
            SHA256=8314673d57e9fb8e01bfc98d074f51f7efb6e55484cfb2b10baed686de2190da; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.2/terraform_1.14.2_linux_arm.zip"; \
            SHA256=01e5a239ad96bc40f37d6eca8cd8b6b0a72ffb227162574c0144a7d0e0741f86; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.2/terraform_1.14.2_linux_arm.zip"; \
            SHA256=01e5a239ad96bc40f37d6eca8cd8b6b0a72ffb227162574c0144a7d0e0741f86; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.2/terraform_1.14.2_linux_arm64.zip"; \
            SHA256=8c9911595ad5079bc34692d75f5ae23a0630868db2b891eef43724411cb5ec88; \
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
