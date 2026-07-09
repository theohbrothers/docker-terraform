FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.8; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_386.zip"; \
            SHA256=9950419b5a5815c92359d55a62103a7444b3c7dad1299e0a3f96b540dc2dba0f; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_amd64.zip"; \
            SHA256=d25ce7b6902013ad905db3d2eab0be4cd905887fe88b81a6171b8d5503c31f3d; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_arm.zip"; \
            SHA256=9e6964abf11a84db1fa84d67adbfb9caf52ef5d03fdc1beb122c66129b9337d4; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_arm.zip"; \
            SHA256=9e6964abf11a84db1fa84d67adbfb9caf52ef5d03fdc1beb122c66129b9337d4; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_arm64.zip"; \
            SHA256=8891e9dcedc9e3b8950bc6af9d4d8af1f4cfade3062f53b9dc403a89f6ce8c9c; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.15.8/terraform_1.15.8_linux_s390x.zip"; \
            SHA256=34bfaa9908417fc05a1236b9866299c7101eb72e5957f6022f0fc3fa10ac10f1; \
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
