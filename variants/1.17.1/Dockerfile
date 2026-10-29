FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.17.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.17.1/terraform_1.17.1_linux_386.zip"; \
            SHA256=8a7f73179421fa35b8d03cb09aee047c7e4ad55a964f7270425efcf942dbe269; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.17.1/terraform_1.17.1_linux_amd64.zip"; \
            SHA256=4638628058e71a55212b1c563712eac03b902128f40740f3dc8174df12135061; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.17.1/terraform_1.17.1_linux_arm.zip"; \
            SHA256=ae74e5eb2f82e3c37f205e479bed89bbdf7da449a3d75b6ae233ab950b4811dc; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.17.1/terraform_1.17.1_linux_arm.zip"; \
            SHA256=ae74e5eb2f82e3c37f205e479bed89bbdf7da449a3d75b6ae233ab950b4811dc; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.17.1/terraform_1.17.1_linux_arm64.zip"; \
            SHA256=988e950a1c23058093b0e66ab2d5fb53fc18345ecfbd5871acf51dbac9325edd; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.17.1/terraform_1.17.1_linux_s390x.zip"; \
            SHA256=1a031803d120142b3ba7cf508fdd31017c40987a3dcd85896496e62e181c41b3; \
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
