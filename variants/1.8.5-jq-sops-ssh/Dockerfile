FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.8.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_386.zip"; \
            SHA256=3d3bda809de29295f7b208c12432eb147ea50186b0e1da9082c2db2a3708415b; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_amd64.zip"; \
            SHA256=bb1ee3e8314da76658002e2e584f2d8854b6def50b7f124e27b957a42ddacfea; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_arm.zip"; \
            SHA256=2cd8cf46c46041c5f46766ec5e96728905df60ef92fd32d9889033ef8c305f46; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_arm.zip"; \
            SHA256=2cd8cf46c46041c5f46766ec5e96728905df60ef92fd32d9889033ef8c305f46; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_arm64.zip"; \
            SHA256=17b3a243ea24003a58ab324c197da8609fccae136bcb8a424bf61ec475b3a203; \
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
