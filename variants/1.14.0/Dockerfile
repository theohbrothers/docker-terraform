FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.0/terraform_1.14.0_linux_arm.zip"; \
            SHA256=13fee8b3da3f128e4d2b0cc0ca4f2a90853f6275a86fa9c9342966eef68590dd; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.0/terraform_1.14.0_linux_amd64.zip"; \
            SHA256=33ac217458ba8b44ce2813553083bc132c9a07e41a79c2e3627977682d283093; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.0/terraform_1.14.0_linux_arm.zip"; \
            SHA256=6388284e9a6bb37b7a386131c6dde9b975eea172170f064e2cc42dffcc572d16; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.0/terraform_1.14.0_linux_arm.zip"; \
            SHA256=6388284e9a6bb37b7a386131c6dde9b975eea172170f064e2cc42dffcc572d16; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.0/terraform_1.14.0_linux_arm64.zip"; \
            SHA256=23d5e9b3f4014f18f85e242a5a8bbaf6d31b058a31d93580e5fe5da644bf8013; \
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
