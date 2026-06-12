FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.6; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.6/terraform_1.15.6_linux_386.zip"; \
            SHA256=b3d6f0c25018544241841200c22a102c91cb97a50c19a313568d139ae4582516; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.6/terraform_1.15.6_linux_amd64.zip"; \
            SHA256=a7150d3b0e1b5c466ad42e8c499954a3c54645f8b56b385fa025d34f7e88faa9; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.6/terraform_1.15.6_linux_arm.zip"; \
            SHA256=82c3251b9346eb22e9855dde97294333f275326bab85ea969a3c195d6f76bf23; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.6/terraform_1.15.6_linux_arm.zip"; \
            SHA256=82c3251b9346eb22e9855dde97294333f275326bab85ea969a3c195d6f76bf23; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.6/terraform_1.15.6_linux_arm64.zip"; \
            SHA256=404c9cfa43728d31005f6e7a848b8a7cc701320067d9d87d8850031a5beb37b0; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.15.6/terraform_1.15.6_linux_s390x.zip"; \
            SHA256=a3fd9a5647458b5274221f3e0629a1b2e4c13fd0dd3c3a7b503f6f4121583662; \
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
