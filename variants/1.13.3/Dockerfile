FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.13.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_386.zip"; \
            SHA256=68444c089d3c467b524c994f039f8b3bfa3362bef0dcf0105d2e2c3099752434; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_amd64.zip"; \
            SHA256=71fc43d92ea09907be5d416d2405a6a9c2d1ceaed633f5e175c0af26e8c4b365; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_arm.zip"; \
            SHA256=cb4a434b83a11d159c8c172b08e9b11b47458befb4e021f5ce20a894dd50c777; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_arm.zip"; \
            SHA256=cb4a434b83a11d159c8c172b08e9b11b47458befb4e021f5ce20a894dd50c777; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_arm64.zip"; \
            SHA256=fa82fb1b08354573467557f33e6a15e7f9e1bba74eb15492f151ca27525d2acc; \
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
