FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_linux_386.zip"; \
            SHA256=42cb7bbd231d27b397fcae0fbb769ca3d7c032acbe6589291a933fdc067cf95f; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_linux_amd64.zip"; \
            SHA256=73bbb8f5188ad75d4fb853fd100ae4d7e146ef7af7db18776109642fdb7759d2; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_linux_arm.zip"; \
            SHA256=be34a411ff07ffd286671e15d0f12aeeea403b64fec2f626990742f0984f37af; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_linux_arm.zip"; \
            SHA256=be34a411ff07ffd286671e15d0f12aeeea403b64fec2f626990742f0984f37af; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_linux_arm64.zip"; \
            SHA256=7a9e92105ede978cf9049a2fbe53dfe67c6a8da4b4d7f613d89e7dd7c63ec40d; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_linux_s390x.zip"; \
            SHA256=4ea470d2a1571d1f0526a704dc20370802f3c0159f619f1908c821b97456ba46; \
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
