FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.3/terraform_1.15.3_linux_386.zip"; \
            SHA256=f9e24d9ccbfd5a29a768b2a5cf3ae531363fc8e05a5d1ebb16b42854167b073c; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.3/terraform_1.15.3_linux_amd64.zip"; \
            SHA256=c3d4b579064745a5f7e918125db23b12ba52a8a7287adb9f32c49d637e02e3bf; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.3/terraform_1.15.3_linux_arm.zip"; \
            SHA256=17e75bf2abb1dc5283e12855a30eb68c4feb14794a94d4cae912f2245115f377; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.3/terraform_1.15.3_linux_arm.zip"; \
            SHA256=17e75bf2abb1dc5283e12855a30eb68c4feb14794a94d4cae912f2245115f377; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.3/terraform_1.15.3_linux_arm64.zip"; \
            SHA256=9824eb010b835b2c872440a337a69acfa1782d36c24d3c09fe5defe75defc511; \
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
