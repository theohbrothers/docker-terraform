FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.8.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.8.1/terraform_1.8.1_linux_386.zip"; \
            SHA256=35eb1f9ec35eac83813b3f27dee62a2d1404af3e9713956ef1f63f7c93783b31; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.8.1/terraform_1.8.1_linux_amd64.zip"; \
            SHA256=265d28a1a6dd81bdd5822eba55663613b7a51c582d663f9417f8777905d39002; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.8.1/terraform_1.8.1_linux_arm.zip"; \
            SHA256=0873b3f09a4710ab8d722e4977f99698b05ea94fef25a16cf5a9302421f45d38; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.8.1/terraform_1.8.1_linux_arm.zip"; \
            SHA256=0873b3f09a4710ab8d722e4977f99698b05ea94fef25a16cf5a9302421f45d38; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.8.1/terraform_1.8.1_linux_arm64.zip"; \
            SHA256=dfc825bd488679163a2768f3c87261ce43b4747720a6cc4e2a63935961ce4582; \
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
