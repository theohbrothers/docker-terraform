FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.5.2; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_386.zip; \
            SHA256=41bd04b8603c8fb5b04ee899a09e78229c6f774d00c7641b2abb5dc271c70a47; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip; \
            SHA256=781ffe0c8888d35b3f5bd0481e951cebe9964b9cfcb27e352f22687975401bcd; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_arm.zip; \
            SHA256=6a3229d9ebe8bfe219568ca7e060ced26e6e568c419a97601f2d9a756b998dbb; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_arm.zip; \
            SHA256=6a3229d9ebe8bfe219568ca7e060ced26e6e568c419a97601f2d9a756b998dbb; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_arm64.zip; \
            SHA256=c39a081830f708fa9e50e5fe1462525ded4de1b4308dcf91f64914d6f4e988b3; \
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
