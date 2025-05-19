FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.7.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_386.zip"; \
            SHA256=e188ce5b45c9d10fa9a5a118438add2eab056d16587f774ecab93e3ca39e1bca; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip"; \
            SHA256=3ff056b5e8259003f67fd0f0ed7229499cfb0b41f3ff55cc184088589994f7a5; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_arm.zip"; \
            SHA256=4e74db9394d5cdf0f91cf8fecd290216edf6cf06273eb8f55e35f26eac4a936a; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_arm.zip"; \
            SHA256=4e74db9394d5cdf0f91cf8fecd290216edf6cf06273eb8f55e35f26eac4a936a; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_arm64.zip"; \
            SHA256=08631c385667dd28f03b3a3f77cb980393af4a2fcfc2236c148a678ad9150c8c; \
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
