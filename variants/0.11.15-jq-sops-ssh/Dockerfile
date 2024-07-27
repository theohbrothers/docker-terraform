FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.11.15; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.11.15/terraform_0.11.15_linux_386.zip"; \
            SHA256=83d55cb7979dac785e2fe409ab9142fd7c4f1c934090776c77c53f3683d404a3; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.11.15/terraform_0.11.15_linux_amd64.zip"; \
            SHA256=e6c8c884de6c353cf98252c5e11faf972d4b30b5d070ab5ff70eaf92660a5aac; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.11.15/terraform_0.11.15_linux_arm.zip"; \
            SHA256=45941c547e3c8f9822173fc2a4b20836db5693e91cbd4da195f414295f05ec53; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.11.15/terraform_0.11.15_linux_arm.zip"; \
            SHA256=45941c547e3c8f9822173fc2a4b20836db5693e91cbd4da195f414295f05ec53; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/0.11.15/terraform_0.11.15_linux_arm64.zip"; \
            SHA256=99be59d7baf6744b496b77b92fe35fbfcd0395a1c2be328a87328406bc81d708; \
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
