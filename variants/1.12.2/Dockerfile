FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.12.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_386.zip"; \
            SHA256=73b380f262324985e911323ecc446066343ffe78add6570a122b7444b04b120b; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip"; \
            SHA256=1eaed12ca41fcfe094da3d76a7e9aa0639ad3409c43be0103ee9f5a1ff4b7437; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_arm.zip"; \
            SHA256=4d5d39d57755a45b7bb6c6ad7301ac3c301eba44b647e2d0ca79c117cb817259; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_arm.zip"; \
            SHA256=4d5d39d57755a45b7bb6c6ad7301ac3c301eba44b647e2d0ca79c117cb817259; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_arm64.zip"; \
            SHA256=f8a0347dc5e68e6d60a9fa2db361762e7943ed084a773f28a981d988ceb6fdc9; \
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
