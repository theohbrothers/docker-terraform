FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.10.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_386.zip"; \
            SHA256=b88293a2ee2ee2aa805fb216229ab06ecd3485cf783dd525379af0faa3ab0789; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_amd64.zip"; \
            SHA256=0566a24f5332098b15716ebc394be503f4094acba5ba529bf5eb0698ed5e2a90; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_arm.zip"; \
            SHA256=c446cbafed29342c9d7d71b8ce977cfc8be45352d9172dab50abac1da3cf0b89; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_arm.zip"; \
            SHA256=c446cbafed29342c9d7d71b8ce977cfc8be45352d9172dab50abac1da3cf0b89; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_arm64.zip"; \
            SHA256=0ca5d6977c7c46bfa4bbe030030b911e897cf0cb72bff5525fb76c10f1c3409a; \
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

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
