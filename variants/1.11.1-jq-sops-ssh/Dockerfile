FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.11.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.11.1/terraform_1.11.1_linux_386.zip"; \
            SHA256=2caf1e54b89d5a779d109b7b0d3c3df4fa97f532a54e63e5f25cb8177777cee8; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.11.1/terraform_1.11.1_linux_amd64.zip"; \
            SHA256=1af58f77958186227bce9ae4d9b08e004fb0902c7a6bdc813cdbab88739f9316; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.11.1/terraform_1.11.1_linux_arm.zip"; \
            SHA256=fa872490ead64fbd55c6f6bff5b229a32eaff58fd038ebc1bb9d88efcab043a5; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.11.1/terraform_1.11.1_linux_arm.zip"; \
            SHA256=fa872490ead64fbd55c6f6bff5b229a32eaff58fd038ebc1bb9d88efcab043a5; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.11.1/terraform_1.11.1_linux_arm64.zip"; \
            SHA256=35ebb4f6a34cec8a5f7983d6d7e25e115f4b8958ac13bd306fe76dcec80967ec; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=terraform.zip; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    unzip "$FILE" terraform; \
    mkdir -pv /usr/local/bin; \
    mv -v terraform /usr/local/bin/terraform; \
    chmod +x /usr/local/bin/terraform; \
    CHECKPOINT_DISABLE=1 terraform version; \
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
