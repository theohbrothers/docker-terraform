FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.11.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.11.2/terraform_1.11.2_linux_386.zip"; \
            SHA256=5c6d482a1d95abfd01f6e8c0382f8424bbcd44b4a05b49beeb62aac5f402fdd6; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.11.2/terraform_1.11.2_linux_amd64.zip"; \
            SHA256=b94f7c5080196081ea5180e8512edd3c2037f28445ce3562cfb0adfd0aab64ca; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.11.2/terraform_1.11.2_linux_arm.zip"; \
            SHA256=576a77c919e0bd8fc224b1b9090e96b1975c7bf1cee096312f2b68a121f1477c; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.11.2/terraform_1.11.2_linux_arm.zip"; \
            SHA256=576a77c919e0bd8fc224b1b9090e96b1975c7bf1cee096312f2b68a121f1477c; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.11.2/terraform_1.11.2_linux_arm64.zip"; \
            SHA256=1f162f947e346f75ac3f6ccfdf5e6910924839f688f0773de9a79bc2e0b4ca94; \
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
