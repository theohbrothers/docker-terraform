FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.7.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_linux_386.zip"; \
            SHA256=f2c21d1189f60ba02963826c90cba7a7e0ee6ee7bede548ad11a015529e5b549; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_linux_amd64.zip"; \
            SHA256=64ea53ae52a7e199bd6f647c31613ea4ef18f58116389051b4a34a29fb04624a; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_linux_arm.zip"; \
            SHA256=31608b8e2e816bd750575515b4ecebb48f4ea8d3f9f27b9bd4818bf3b978bbeb; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_linux_arm.zip"; \
            SHA256=31608b8e2e816bd750575515b4ecebb48f4ea8d3f9f27b9bd4818bf3b978bbeb; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_linux_arm64.zip"; \
            SHA256=9067cd7e34b3f81aa6e1eca3496dae65573abe3b9e285ec651c1c2fd2f9c43cd; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=terraform.zip; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    unzip "$FILE" terraform; \
    mkdir -pv /usr/local/bin; \
    mv -v terraform /usr/local/bin/terraform; \
    chmod +x /usr/local/bin/terraform; \
    CHECKPOINT_DISABLE=1 terraform version; \
    :

RUN apk add --no-cache ca-certificates

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
