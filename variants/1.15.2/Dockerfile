FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.2/terraform_1.15.2_linux_386.zip"; \
            SHA256=aa754edbb9cf035cf15f820514123cb7c452875c27005f1beea1ed3665f40962; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.2/terraform_1.15.2_linux_amd64.zip"; \
            SHA256=c56ff2bc7e6ce9b3879a50392b03c2ea074b47688bf503ff966c87fb01b2aab8; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.2/terraform_1.15.2_linux_arm.zip"; \
            SHA256=6e0f8ab581563adb707587ae5ae58ca1ee210c7f719795671d6f922bcb76d708; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.2/terraform_1.15.2_linux_arm.zip"; \
            SHA256=6e0f8ab581563adb707587ae5ae58ca1ee210c7f719795671d6f922bcb76d708; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.2/terraform_1.15.2_linux_arm64.zip"; \
            SHA256=cf27657e96bbdc6116f4c16a0c801d36ae6410d7210183a520ac6b2198fb723e; \
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
