FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.4/terraform_1.16.4_linux_386.zip"; \
            SHA256=d35c5020946ec61311a85a6819facac5c5b0d4241668c2508deb8e29ef5afe91; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.4/terraform_1.16.4_linux_amd64.zip"; \
            SHA256=dc94af0eef1147718ad7c8daea792ed199e3e0492eec180d0adafa2a65a879df; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.4/terraform_1.16.4_linux_arm.zip"; \
            SHA256=94f9b3fc5f8b9d01392ffb5347af0bad5f6a79bcfdba61936b49279eef60840f; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.4/terraform_1.16.4_linux_arm.zip"; \
            SHA256=94f9b3fc5f8b9d01392ffb5347af0bad5f6a79bcfdba61936b49279eef60840f; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.4/terraform_1.16.4_linux_arm64.zip"; \
            SHA256=8263f301cb1a24489a4adeed147bf28504053f77237b3ea97a0ef2972659de30; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.4/terraform_1.16.4_linux_s390x.zip"; \
            SHA256=562efe3accda3cb08be038ca6377b8b555b33d2b6457ba4a8e11b83dcf22377f; \
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

CMD [ "terraform" ]
