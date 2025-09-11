FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.13.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.13.2/terraform_1.13.2_linux_386.zip"; \
            SHA256=3be93ccb7a3b68af4bec8e1039f127d697370f122f42bfe8df049620df79a74e; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.13.2/terraform_1.13.2_linux_amd64.zip"; \
            SHA256=b7554c87f36dbb2231d54c4277cbbddf58ae8ba916fa97461564836a2c4954c0; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.13.2/terraform_1.13.2_linux_arm.zip"; \
            SHA256=6b61e2791d09a5d07adfbbc0f4393c3ad0daff76a68b5bd24e6889ab91aecc39; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.13.2/terraform_1.13.2_linux_arm.zip"; \
            SHA256=6b61e2791d09a5d07adfbbc0f4393c3ad0daff76a68b5bd24e6889ab91aecc39; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.13.2/terraform_1.13.2_linux_arm64.zip"; \
            SHA256=9b3814d36b5b22d9bc7a2856a676770c7b2597b8df025004054354226865ced6; \
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
