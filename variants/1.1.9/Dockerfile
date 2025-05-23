FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.1.9; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_386.zip"; \
            SHA256=a29a5c069e1712753ed553f7c6e63f1cd35caefee73496210461c05158b836b4; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip"; \
            SHA256=9d2d8a89f5cc8bc1c06cb6f34ce76ec4b99184b07eb776f8b39183b513d7798a; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_arm.zip"; \
            SHA256=800eee18651b5e552772c60fc1b5eb00cdcefddf11969412203c6de6189aa10a; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_arm.zip"; \
            SHA256=800eee18651b5e552772c60fc1b5eb00cdcefddf11969412203c6de6189aa10a; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_arm64.zip"; \
            SHA256=e8a09d1fe5a68ed75e5fabe26c609ad12a7e459002dea6543f1084993b87a266; \
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
