FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.9.11; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_386.zip"; \
            SHA256=5c4b95c0d4967051763ded642f868d4fd7783eb49d6a07f57c1d2e0de0e1cdf4; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip"; \
            SHA256=804d31cfa5fee5c2b1bff7816b64f0e26b1d766ac347c67091adccc2626e16f3; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_arm.zip"; \
            SHA256=4f9ae0f2135dd98d752adb36b251c616486ec1dcf709a9ceda8e04787b287023; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_arm.zip"; \
            SHA256=4f9ae0f2135dd98d752adb36b251c616486ec1dcf709a9ceda8e04787b287023; \
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

RUN apk add --no-cache libvirt-client

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
