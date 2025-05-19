FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.2.9; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_amd64.zip"; \
            SHA256=f9028c4834cd3f2d20975e8ae9897e48f811bb8d494b734a87dab0d3968039c7; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_amd64.zip"; \
            SHA256=0e0fc38641addac17103122e1953a9afad764a90e74daf4ff8ceeba4e362f2fb; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_arm.zip"; \
            SHA256=647a69acf01b3cac829f4436e8095d927ee6732cd6c076e24674a3c09326aad2; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_arm.zip"; \
            SHA256=647a69acf01b3cac829f4436e8095d927ee6732cd6c076e24674a3c09326aad2; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_arm64.zip"; \
            SHA256=6da7bf01f5a72e61255c2d80eddeba51998e2bb1f50a6d81b0d3b71e70e18531; \
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

RUN apk add --no-cache jq

RUN apk add --no-cache libvirt-client

RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Install step
RUN set -eux; \
    STEP_VERSION=v0.27.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://github.com/smallstep/cli/releases/download/v0.27.5/step_linux_386.tar.gz"; \
            SHA256=a4cb4cb893424780ffb4c8fee4ecf5b92e93c4c9b7ebd242631c272197dff2e0; \
            ;; \
        'x86_64') \
            URL="https://github.com/smallstep/cli/releases/download/v0.27.5/step_linux_amd64.tar.gz"; \
            SHA256=2099be3d0cc7bc3559d771393378aa6c3e96908a929dccd570c8352e2440ad77; \
            ;; \
        'armhf') \
            URL="https://github.com/smallstep/cli/releases/download/v0.27.5/step_linux_armv6.tar.gz"; \
            SHA256=97e8827c0ccfbf7779878f9a54b6fa72ba9aca4aead380d7a1cd85bebb04f365; \
            ;; \
        'armv7l') \
            URL="https://github.com/smallstep/cli/releases/download/v0.27.5/step_linux_armv7.tar.gz"; \
            SHA256=c0adeba5d5c2bcf70edf5f626d48c3201c204fe671591c12005cf5b4d6e90349; \
            ;; \
        'aarch64') \
            URL="https://github.com/smallstep/cli/releases/download/v0.27.5/step_linux_arm64.tar.gz"; \
            SHA256=f7f52300c3550bfb5a21a5fb2610dced6c3d24a008bec7e968987e7bc67f7ff4; \
            ;; \
        'ppc64le') \
            URL="https://github.com/smallstep/cli/releases/download/v0.27.5/step_linux_ppc64le.tar.gz"; \
            SHA256=0ac0e38b2f0c3b3a075a00adba43e1a0bca1549d0e13293bd3205416cd993974; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=step.tar.gz; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    mkdir -p extract; \
    tar -C extract -xvf "$FILE" --no-same-owner --no-same-permissions; \
    mkdir -pv /usr/local/bin; \
    BIN=$( find extract -type f -name "step" | head -n1 ); \
    mv -v "$BIN" /usr/local/bin/step; \
    chmod +x /usr/local/bin/step; \
    step version; \
    rm -rf extract; \
    rm -f "$FILE"; \
    :

CMD [ "terraform" ]
