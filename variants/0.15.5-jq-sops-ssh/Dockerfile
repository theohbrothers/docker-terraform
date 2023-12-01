FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.15.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_386.zip"; \
            SHA256=0155d6844ae554021f8ca58b57f1e6dda7d88b6cf1d02113f3a3480e178c46b9; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_amd64.zip"; \
            SHA256=3b144499e08c245a8039027eb2b84c0495e119f57d79e8fb605864bb48897a7d; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_arm.zip"; \
            SHA256=3122e7ac6353d488d766ac84379139e3d14f564fbe61f4b069f7584ca9c29e01; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_arm.zip"; \
            SHA256=3122e7ac6353d488d766ac84379139e3d14f564fbe61f4b069f7584ca9c29e01; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_arm64.zip"; \
            SHA256=bc5a9d734010e55fb374a4cab9eb0539139d34fd84f58d2242573f275f67fc13; \
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
