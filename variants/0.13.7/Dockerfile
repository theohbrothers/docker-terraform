FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.13.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_386.zip"; \
            SHA256=90df3c9e8a9facf93631c6d338b867db391b435a39a1ca0a02ae4908f01dc2ea; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_amd64.zip"; \
            SHA256=4a52886e019b4fdad2439da5ff43388bbcc6cce9784fde32c53dcd0e28ca9957; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_arm.zip"; \
            SHA256=9af803e215be58ed6cf89e9d22b826d7b3634bef70dc94abc13fdd2bd85b1f80; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_arm.zip"; \
            SHA256=9af803e215be58ed6cf89e9d22b826d7b3634bef70dc94abc13fdd2bd85b1f80; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_arm64.zip"; \
            SHA256=59b85b7b4b4b2939a4c05db905100dd8808f8df8b5a0e8a00a26e7dcf0c4a2be; \
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
