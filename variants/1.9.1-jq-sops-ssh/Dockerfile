FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.1/terraform_1.9.1_linux_386.zip"; \
            SHA256=801d8756eee1220585f839ade9f18441ce1b855882df34e4cf9668ca0bec9192; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.1/terraform_1.9.1_linux_amd64.zip"; \
            SHA256=c3e1dade1c81fdc5e293529e480709f047c0113ea9feb8d9f35002df09ec6a34; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.1/terraform_1.9.1_linux_arm.zip"; \
            SHA256=43e9520b222daadda3640524e6e8941d0f4f453df0fe99e93265a7c7f9d7afea; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.1/terraform_1.9.1_linux_arm.zip"; \
            SHA256=43e9520b222daadda3640524e6e8941d0f4f453df0fe99e93265a7c7f9d7afea; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.1/terraform_1.9.1_linux_arm64.zip"; \
            SHA256=f1426fccbf2500202b37993ef6b92e1fc60d114dd32c79bfadbc843929b2c7e2; \
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
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
