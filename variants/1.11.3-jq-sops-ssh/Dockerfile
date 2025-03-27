FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.11.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.11.3/terraform_1.11.3_linux_386.zip"; \
            SHA256=f5a4250f371df3b9b54b7f802495a9e341a8846e3536f673d1f8c1d28e8c0b85; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.11.3/terraform_1.11.3_linux_amd64.zip"; \
            SHA256=377c8c18e2beab24f721994859236e98383350bf767921436511370d1f7c472b; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.11.3/terraform_1.11.3_linux_arm.zip"; \
            SHA256=9bf99463a9353a4242a5650fedc20833537db26c0aa7063ab673a179a5a7ba26; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.11.3/terraform_1.11.3_linux_arm.zip"; \
            SHA256=9bf99463a9353a4242a5650fedc20833537db26c0aa7063ab673a179a5a7ba26; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.11.3/terraform_1.11.3_linux_arm64.zip"; \
            SHA256=d685953bec501c0acda13319f34dddaadf33a8f553c85533531d3c7d5f84604a; \
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
