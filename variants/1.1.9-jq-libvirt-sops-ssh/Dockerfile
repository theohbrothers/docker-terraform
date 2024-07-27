FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.1.9; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_386.zip"; \
            SHA256=a29a5c069e1712753ed553f7c6e63f1cd35caefee73496210461c05158b836b4; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip"; \
            SHA256=9d2d8a89f5cc8bc1c06cb6f34ce76ec4b99184b07eb776f8b39183b513d7798a; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_arm.zip"; \
            SHA256=800eee18651b5e552772c60fc1b5eb00cdcefddf11969412203c6de6189aa10a; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_arm.zip"; \
            SHA256=800eee18651b5e552772c60fc1b5eb00cdcefddf11969412203c6de6189aa10a; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_arm64.zip"; \
            SHA256=e8a09d1fe5a68ed75e5fabe26c609ad12a7e459002dea6543f1084993b87a266; \
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
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
