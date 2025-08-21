FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.13.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.13.0/terraform_1.13.0_linux_386.zip"; \
            SHA256=1ec95a4408bc7a1378dc4519678b0d49e75255de8f06bca90cc72d918b0c2863; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.13.0/terraform_1.13.0_linux_amd64.zip"; \
            SHA256=de8ef905f84f24675da202a6967fddc40b2b23c15fc92a5007570f46a9fcc104; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.13.0/terraform_1.13.0_linux_arm.zip"; \
            SHA256=d76a52b9e8dc083a5a4d24b617ef6a1d2f347619291dbd2d643767e2bfcedccb; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.13.0/terraform_1.13.0_linux_arm.zip"; \
            SHA256=d76a52b9e8dc083a5a4d24b617ef6a1d2f347619291dbd2d643767e2bfcedccb; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.13.0/terraform_1.13.0_linux_arm64.zip"; \
            SHA256=e35a908e406536ef1ba7b853dc0e0fed141630e04ba4b8004edeea1919aac385; \
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
