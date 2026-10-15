FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.6; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.6/terraform_1.16.6_linux_386.zip"; \
            SHA256=f1b81dd7e62117507717b8488fef260879d226e149a302031fa94a3cc2f7e875; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.6/terraform_1.16.6_linux_amd64.zip"; \
            SHA256=38034b38d03096399a7a1264a14561a8029b2b496fd1f169452656e53968f1b7; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.6/terraform_1.16.6_linux_arm.zip"; \
            SHA256=d86a3f37fc60fd8d173d3c966957d8a0fa7c8ee131ee9ec100be8d06733c7728; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.6/terraform_1.16.6_linux_arm.zip"; \
            SHA256=d86a3f37fc60fd8d173d3c966957d8a0fa7c8ee131ee9ec100be8d06733c7728; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.6/terraform_1.16.6_linux_arm64.zip"; \
            SHA256=a750b5a11038f165846b2658c40c88cd7070aa67a61bab431a14ba27928ea9ea; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.6/terraform_1.16.6_linux_s390x.zip"; \
            SHA256=9302c7b81e6e93fc6dfda2305955bd1ba28a14e8ac4c70bc26b97262dd7ce1b6; \
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
