FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.13.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.13.5/terraform_1.13.5_linux_386.zip"; \
            SHA256=3369e665e1de0d43b59ea79e9ca96432e91b5fc4c734d5f0ce8c214e03a6c989; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.13.5/terraform_1.13.5_linux_amd64.zip"; \
            SHA256=0dbe3fcc268eb670801af6a6456799d1ae26e72e73797f6c6167e18aafd1fd9a; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.13.5/terraform_1.13.5_linux_arm.zip"; \
            SHA256=33ced3ed54c828ece06a9e84f43a8737686640208c0c1d36be830c34012714f0; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.13.5/terraform_1.13.5_linux_arm.zip"; \
            SHA256=33ced3ed54c828ece06a9e84f43a8737686640208c0c1d36be830c34012714f0; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.13.5/terraform_1.13.5_linux_arm64.zip"; \
            SHA256=fc1ddcb403fb57e25bdbdceb1ef2b1a102650c01b4d65dd3410082d2ef8b4417; \
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
