FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.5/terraform_1.15.5_linux_386.zip"; \
            SHA256=b265c8fbdeaf961dc04f4c9d57c43dd1fa9b01851a2495a847e8bec2e7411e08; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.5/terraform_1.15.5_linux_amd64.zip"; \
            SHA256=702b2136af6728c8ff037f843dd2dbce2b7ad88786b7381d1d72aefa250f601c; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.5/terraform_1.15.5_linux_arm.zip"; \
            SHA256=c7e8449432674fe642f469b9e7360258e2e34581312e4a95448abd6d8212622d; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.5/terraform_1.15.5_linux_arm.zip"; \
            SHA256=c7e8449432674fe642f469b9e7360258e2e34581312e4a95448abd6d8212622d; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.5/terraform_1.15.5_linux_arm64.zip"; \
            SHA256=06e7b48de826146c6d9331ba35b13da12332d8392be30d1dd6b789ba4713fff0; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.15.5/terraform_1.15.5_linux_s390x.zip"; \
            SHA256=a92d35cc35b2ac96518ce8f1e1c149cf593dd61340a70477cd852ea5fb2352ce; \
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
