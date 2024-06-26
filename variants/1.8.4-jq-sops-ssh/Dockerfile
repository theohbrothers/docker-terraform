FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.8.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_386.zip"; \
            SHA256=30ef1ae737fa4c90a527378159de2f2a9d32cec6e6a2ea73c3a9615eed443733; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_amd64.zip"; \
            SHA256=12167574ae0deb219a1008bd4c15ff13dac7198d57870f48433d53fe2b0b28c4; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_arm.zip"; \
            SHA256=45d65148dcb75c2ddde093a0f1c222604470bf7584b9ab6cd36b99dad8ba9f1f; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_arm.zip"; \
            SHA256=45d65148dcb75c2ddde093a0f1c222604470bf7584b9ab6cd36b99dad8ba9f1f; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_arm64.zip"; \
            SHA256=76668e7742ee8f815fe6de28c8b84507e6171b26966426c2eb8eea8e64fe2f33; \
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
