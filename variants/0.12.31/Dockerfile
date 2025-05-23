FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.12.31; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.12.31/terraform_0.12.31_linux_386.zip"; \
            SHA256=abdd13b29cac315900246bf8ebff19040dbc1ae6ce99c1348e1bc59ba04241f1; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.12.31/terraform_0.12.31_linux_amd64.zip"; \
            SHA256=e5eeba803bc7d8d0cae7ef04ba7c3541c0abd8f9e934a5e3297bf738b31c5c6d; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.12.31/terraform_0.12.31_linux_arm.zip"; \
            SHA256=f5894ebdc8aceb12da840045508c362eb0f923e4b5115bb601fefa8f1f1d3cb9; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.12.31/terraform_0.12.31_linux_arm.zip"; \
            SHA256=f5894ebdc8aceb12da840045508c362eb0f923e4b5115bb601fefa8f1f1d3cb9; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/0.12.31/terraform_0.12.31_linux_arm64.zip"; \
            SHA256=737205d76f576e47a5d7a41e506b2ec8eb7a0f6a0b3b3b0a8de59551c2f2b77f; \
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
