FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.11.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.11.0/terraform_1.11.0_linux_386.zip"; \
            SHA256=4e29a4e8ee8a12e625c5c058012b7c56710c5724ab1c959f47a2f7fc1b9eaf5e; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.11.0/terraform_1.11.0_linux_amd64.zip"; \
            SHA256=069e531fd4651b9b510adbd7e27dd648b88d66d5f369a2059aadbb4baaead1c1; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.11.0/terraform_1.11.0_linux_arm.zip"; \
            SHA256=916d151d3dfd4aada61f0a269bfde9484582ba0ade049c9e554b8c998d92f9fd; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.11.0/terraform_1.11.0_linux_arm.zip"; \
            SHA256=916d151d3dfd4aada61f0a269bfde9484582ba0ade049c9e554b8c998d92f9fd; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.11.0/terraform_1.11.0_linux_arm64.zip"; \
            SHA256=0a7e88cbb431044a16335369f850359def93b2898adc1778063784760db69093; \
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
