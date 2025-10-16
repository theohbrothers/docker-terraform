FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.13.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.13.4/terraform_1.13.4_linux_386.zip"; \
            SHA256=3aa568420e3c8d256ee65c05c57f4022e5f66c771f99519b5dd34384acfd9bb5; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.13.4/terraform_1.13.4_linux_amd64.zip"; \
            SHA256=98aa516201e948306698efd9954ab4cc0d1227c2578ba56245898b5f679e590b; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.13.4/terraform_1.13.4_linux_arm.zip"; \
            SHA256=e0eff849907d73ef372b317f7337ab879533133c029773e8786018df8651461f; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.13.4/terraform_1.13.4_linux_arm.zip"; \
            SHA256=e0eff849907d73ef372b317f7337ab879533133c029773e8786018df8651461f; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.13.4/terraform_1.13.4_linux_arm64.zip"; \
            SHA256=a17bde150a4d6c9e7ece063ab634c07723b8242e078f3ae9017486277d6690c4; \
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
