FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.12.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.12.0/terraform_1.12.0_linux_386.zip"; \
            SHA256=76782e50136119c45b4a3e53a317cebf7d4682f7964fbce697b582e387aea506; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.12.0/terraform_1.12.0_linux_amd64.zip"; \
            SHA256=c71fd5d500a7e4d869bf5d12176c72d1dfc00440b862116797694361671f77c8; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.12.0/terraform_1.12.0_linux_arm.zip"; \
            SHA256=c7f9a2e0ddba0b1ddbf17b3dec3dd4c5cd72f7397a92f9df38b9ff3ce7d4b693; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.12.0/terraform_1.12.0_linux_arm.zip"; \
            SHA256=c7f9a2e0ddba0b1ddbf17b3dec3dd4c5cd72f7397a92f9df38b9ff3ce7d4b693; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.12.0/terraform_1.12.0_linux_arm64.zip"; \
            SHA256=8174792e28419601db6445f3252f792bc84c14358f6fe1c65d2951d89b36fadf; \
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
