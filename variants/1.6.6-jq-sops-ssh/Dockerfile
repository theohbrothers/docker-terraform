FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.6.6; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_386.zip"; \
            SHA256=fbe1ea5d043f0f4785fd02948a4cecda111e24741bf6d8fe5a67415416ddf246; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip"; \
            SHA256=d117883fd98b960c5d0f012b0d4b21801e1aea985e26949c2d1ebb39af074f00; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_arm.zip"; \
            SHA256=4a5342a4577d462d880bc392e808f453b101a48aaf383baf99383999a2254fc7; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_arm.zip"; \
            SHA256=4a5342a4577d462d880bc392e808f453b101a48aaf383baf99383999a2254fc7; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_arm64.zip"; \
            SHA256=4066567f4ba031036d9b14c1edb85399aac1cfd6bbec89cdd8c26199adb2793b; \
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

RUN apk add --no-cache ca-certificates

RUN apk add --no-cache jq

RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
