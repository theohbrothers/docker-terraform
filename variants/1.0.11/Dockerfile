FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.0.11; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_386.zip"; \
            SHA256=143d01fb4bacf8dd97918fb2e1ad38d4489fbe9f5669a32d0adb69ce3e9aecea; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip"; \
            SHA256=eeb46091a42dc303c3a3c300640c7774ab25cbee5083dafa5fd83b54c8aca664; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_arm.zip"; \
            SHA256=cce11dd382af930ef20234d84695d187bf869e366e7d91337068719ff1a7c843; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_arm.zip"; \
            SHA256=cce11dd382af930ef20234d84695d187bf869e366e7d91337068719ff1a7c843; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_arm64.zip"; \
            SHA256=30c650f4bc218659d43e07d911c00f08e420664a3d12c812228e66f666758645; \
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
