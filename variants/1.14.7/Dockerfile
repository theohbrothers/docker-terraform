FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.7/terraform_1.14.7_linux_386.zip"; \
            SHA256=fa711cc6c7d0cd03aac82f642e1ef7d2b101b8b632d17fd08695febdbd6bf6cb; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.7/terraform_1.14.7_linux_amd64.zip"; \
            SHA256=e8bbcefea8015156e04e2a325cde37a0b2fb761728bda548e2fe3b8ad7c18c96; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.7/terraform_1.14.7_linux_arm.zip"; \
            SHA256=48b8c04e472ce05c6df945513c0014335fa52117fba602903ade89f571b2ec09; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.7/terraform_1.14.7_linux_arm.zip"; \
            SHA256=48b8c04e472ce05c6df945513c0014335fa52117fba602903ade89f571b2ec09; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.7/terraform_1.14.7_linux_arm64.zip"; \
            SHA256=04f88ee8924db27c0e26c379721965273c80c9b6a94bc5d8d8048a69163952ba; \
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
