FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.7/terraform_1.16.7_linux_386.zip"; \
            SHA256=8b44e5e21ff8c4961190e6e08061f4ba232f51efaa1f13aac56680bdd78f7a3d; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.7/terraform_1.16.7_linux_amd64.zip"; \
            SHA256=5454efcf7fc87f0c2113111b9a5c7182f0ca1c6f0f23a1e110a50770a8fe473b; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.7/terraform_1.16.7_linux_arm.zip"; \
            SHA256=4a0a478c5d62aa775d6136942f84f87c3557df01283c869ef2ceba2baa389510; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.7/terraform_1.16.7_linux_arm.zip"; \
            SHA256=4a0a478c5d62aa775d6136942f84f87c3557df01283c869ef2ceba2baa389510; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.7/terraform_1.16.7_linux_arm64.zip"; \
            SHA256=2d6a3f1098de94f1672aaa4e6873ef91ade9eac38851d3a403e2009193208de4; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.7/terraform_1.16.7_linux_s390x.zip"; \
            SHA256=eb520f390d06d75a24f6861db14ea03227e2dcde5c24215dedcff710eb705384; \
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
