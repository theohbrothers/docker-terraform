FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.9; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.9/terraform_1.15.9_linux_386.zip"; \
            SHA256=5caaa32a7099dd40efb43679e3921095b665edd277b3c4be82e65a83f2e4fc84; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.9/terraform_1.15.9_linux_amd64.zip"; \
            SHA256=76edd0b22d2f27d3d2e097cd793209646f719cf60f02ff3af626b07361137da1; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.9/terraform_1.15.9_linux_arm.zip"; \
            SHA256=9b7a67a2ff2db4768a697db96fa5859ae4c9490f7c4f365fa8b9b40ec7b870ae; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.9/terraform_1.15.9_linux_arm.zip"; \
            SHA256=9b7a67a2ff2db4768a697db96fa5859ae4c9490f7c4f365fa8b9b40ec7b870ae; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.9/terraform_1.15.9_linux_arm64.zip"; \
            SHA256=0afa6c29f61ca5ea270e950e43e50ecf2418b598507bf580e8ae76e1e6699b19; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.15.9/terraform_1.15.9_linux_s390x.zip"; \
            SHA256=ae3a721b35b1636de7e72bc011bedc3d3772988858416f1ac85aee0b2f57b644; \
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
