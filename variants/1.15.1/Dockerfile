FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.1/terraform_1.15.1_linux_386.zip"; \
            SHA256=725a2cec1953c117489e29479b83c5e135ea35af4cd37e76e48fb1390d45b07f; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.1/terraform_1.15.1_linux_amd64.zip"; \
            SHA256=0921fee8c8435253ca49390a02109e906042e611a4e17f69e922261f5176c74f; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.1/terraform_1.15.1_linux_arm.zip"; \
            SHA256=1921973745aeb4117a5af4dd74cbfa34ef357540ba048df3fa376bbad3a6692c; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.1/terraform_1.15.1_linux_arm.zip"; \
            SHA256=1921973745aeb4117a5af4dd74cbfa34ef357540ba048df3fa376bbad3a6692c; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.1/terraform_1.15.1_linux_arm64.zip"; \
            SHA256=d0e5707a2ef8ff05dc546b8c0acee5b6f6968ba83c1208230364187a56480b42; \
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
