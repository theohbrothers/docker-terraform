FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.9; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_386.zip"; \
            SHA256=3ef51f4e684336750bd07c7b660d6000f7585de193741944f2cebdbc6f062d5c; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_amd64.zip"; \
            SHA256=2e5cffc20a0b48a67a76268723bd5a10b8666f69b2aa4f04906e206726bedd63; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_arm.zip"; \
            SHA256=0086d4f9b58a83e37b2e6754f7a90139c643991e5674ed766b2be0e497c2a0f8; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_arm.zip"; \
            SHA256=0086d4f9b58a83e37b2e6754f7a90139c643991e5674ed766b2be0e497c2a0f8; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.9/terraform_1.14.9_linux_arm64.zip"; \
            SHA256=863002085b886453795d9ff4b8989b8468784478150b70ba8a1df3e3ad66da99; \
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
