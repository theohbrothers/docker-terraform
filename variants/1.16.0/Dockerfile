FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.0/terraform_1.16.0_linux_386.zip"; \
            SHA256=1a61829dea3bb5194433f8a44619cd696817706fb4e2d67caaa56aa0bdc6bde3; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.0/terraform_1.16.0_linux_amd64.zip"; \
            SHA256=41d05b927aa174f15d1228c4eba832a323b716c68b415ef5a00179f46cc602d3; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.0/terraform_1.16.0_linux_arm.zip"; \
            SHA256=ae6f7a891fa7d65b30d7c1cebcd02b2ea2998632ec3def200b4fb9d3d3f135c9; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.0/terraform_1.16.0_linux_arm.zip"; \
            SHA256=ae6f7a891fa7d65b30d7c1cebcd02b2ea2998632ec3def200b4fb9d3d3f135c9; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.0/terraform_1.16.0_linux_arm64.zip"; \
            SHA256=60f86cea49a653e22a93c000f16cbfa391ce41c6f6a11d36557c35da411f684c; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.0/terraform_1.16.0_linux_s390x.zip"; \
            SHA256=7d8aa18a921a287bd79fbb262a325b8210c10cd34732a83a0d6e267a3f62d46f; \
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
