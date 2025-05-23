FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.10.8; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_386.zip"; \
            SHA256=a13ee4fb98fe0b219678934d72efaafd4b59fe10036a7de4cb769d51a9246ee5; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_amd64.zip"; \
            SHA256=b786c0cf936e24145fad632efd0fe48c831558cc9e43c071fffd93f35e3150db; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_arm.zip"; \
            SHA256=f0dd85b3fbdc0e873dd7cc59b96ce2d70467d8326575d79e853718b0baa79cc0; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_linux_arm.zip"; \
            SHA256=f0dd85b3fbdc0e873dd7cc59b96ce2d70467d8326575d79e853718b0baa79cc0; \
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
