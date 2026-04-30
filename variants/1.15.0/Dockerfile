FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.0/terraform_1.15.0_linux_386.zip"; \
            SHA256=4071abb329243e3fcc4eb7ce6cbb041aa0490b7c1d687b8eedd2af3ec606a906; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.0/terraform_1.15.0_linux_amd64.zip"; \
            SHA256=dcd4b31225dd960404f744315c0c3823a7deeda43bca0256a17fc762092d7e1b; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.0/terraform_1.15.0_linux_arm.zip"; \
            SHA256=9ac454828c9092cb0041b3fcf57a3af700f62ed94f2d5ccd2152d1596556473a; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.0/terraform_1.15.0_linux_arm.zip"; \
            SHA256=9ac454828c9092cb0041b3fcf57a3af700f62ed94f2d5ccd2152d1596556473a; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.0/terraform_1.15.0_linux_arm64.zip"; \
            SHA256=7d9b8ab81790771b5c872c06a8982bc25b66971928dccb244fe0a41e2451770a; \
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
