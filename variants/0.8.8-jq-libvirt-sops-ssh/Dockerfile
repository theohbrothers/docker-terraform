FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.8.8; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.8.8/terraform_0.8.8_linux_386.zip"; \
            SHA256=d483dd90baf752e18af030738a68540e8237ceee5a9ce6f3882cfa7efda7ac1b; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.8.8/terraform_0.8.8_linux_amd64.zip"; \
            SHA256=403d65b8a728b8dffcdd829262b57949bce9748b91f2e82dfd6d61692236b376; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.8.8/terraform_0.8.8_linux_arm.zip"; \
            SHA256=7591914ba8a64db00b8fc8ac9379643a519a2f796ffe2cc424790a7d1bd99763; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.8.8/terraform_0.8.8_linux_arm.zip"; \
            SHA256=7591914ba8a64db00b8fc8ac9379643a519a2f796ffe2cc424790a7d1bd99763; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=terraform.zip; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    unzip "$FILE" -d extract; \
    mkdir -pv /usr/local/bin; \
    BIN=$( find extract -type f -name "terraform" | head -n1 ); \
    mv -v "$BIN" /usr/local/bin/terraform; \
    chmod +x /usr/local/bin/terraform; \
    CHECKPOINT_DISABLE=1 terraform version; \
    rm -rf extract; \
    rm -f "$FILE"; \
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
