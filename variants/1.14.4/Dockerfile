FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.4/terraform_1.14.4_linux_386.zip"; \
            SHA256=19cbe19b85ccacd8eec7e6b3ec4cb626b48224dac73572bafe43a27993db295b; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.4/terraform_1.14.4_linux_amd64.zip"; \
            SHA256=4a24b18865d9419ba7882567cb7429dd1525b3e2029a9e38f612d476ba8c3dea; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.4/terraform_1.14.4_linux_arm.zip"; \
            SHA256=53f0c649628ccb2ba466faa90306f65143e3a84b86085f1a285039fec03a77a1; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.4/terraform_1.14.4_linux_arm.zip"; \
            SHA256=53f0c649628ccb2ba466faa90306f65143e3a84b86085f1a285039fec03a77a1; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.4/terraform_1.14.4_linux_arm64.zip"; \
            SHA256=dcbc9d4b9fcd47e76ae194d5d569bfbf9f15bf1c59ca692aff6d2a92eb8e8994; \
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
