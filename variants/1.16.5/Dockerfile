FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_linux_386.zip"; \
            SHA256=e6de7a0b4acfb6cb4daba5c654dc86efb2b5c2af8ecd58b2a28983a289685619; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_linux_amd64.zip"; \
            SHA256=2bc2fcfff033265c9e02ca0351f01794eb122f62a9b2a49a3294b9e49eaab5e4; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_linux_arm.zip"; \
            SHA256=e69839d7c3e8d7d1c49e78a1ca6902e95818a14179dad8732b13171bbc60809e; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_linux_arm.zip"; \
            SHA256=e69839d7c3e8d7d1c49e78a1ca6902e95818a14179dad8732b13171bbc60809e; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_linux_arm64.zip"; \
            SHA256=61a50b00485ee4810cf20581ef080fc54d34d666e175c58d9a10501c65c1ccde; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.5/terraform_1.16.5_linux_s390x.zip"; \
            SHA256=92b56b8b251a479931f97f682e5a90044be1239c537d29ae21eaea299aafd9ed; \
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
