FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.11.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_386.zip"; \
            SHA256=8e4bd232ce8b0cde2a90132a9c4d25665791c7a48bbb159f5cd4988265d10372; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_amd64.zip"; \
            SHA256=1ce994251c00281d6845f0f268637ba50c0005657eb3cf096b92f753b42ef4dc; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_arm.zip"; \
            SHA256=3cf072a049ab0178e9cbec47a14712ba7f38cc8ef061f3a7c0ff57b83d320edd; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_arm.zip"; \
            SHA256=3cf072a049ab0178e9cbec47a14712ba7f38cc8ef061f3a7c0ff57b83d320edd; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_arm64.zip"; \
            SHA256=a43d1d0da9b9bab214a8305a39db0e40869572594ccf50c416a7756499143633; \
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
