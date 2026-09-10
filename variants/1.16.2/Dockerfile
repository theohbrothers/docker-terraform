FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.2/terraform_1.16.2_linux_386.zip"; \
            SHA256=40b90f2f6d73e8622a73e5fa76989da2afcb83a2ab872ad2472844c13fd86506; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.2/terraform_1.16.2_linux_amd64.zip"; \
            SHA256=0d17011f0c4664539b164b044903d04e296c86c13cb9f28040076c65cfb3985a; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.2/terraform_1.16.2_linux_arm.zip"; \
            SHA256=456d3fc4b2d3b04509cdc0bd1f00fe4535d2c4c8c74e7da729864bc75b67335b; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.2/terraform_1.16.2_linux_arm.zip"; \
            SHA256=456d3fc4b2d3b04509cdc0bd1f00fe4535d2c4c8c74e7da729864bc75b67335b; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.2/terraform_1.16.2_linux_arm64.zip"; \
            SHA256=c040bd1e3122b4290f70f74288d8c5a54ddd4254a3e52a29e7cc666653f50a0a; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.2/terraform_1.16.2_linux_s390x.zip"; \
            SHA256=a85f0d3b26408718f59f5dd33e52fc96093e5245d215999093bc4dd60470d2a3; \
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
