FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.2.9; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_amd64.zip"; \
            SHA256=f9028c4834cd3f2d20975e8ae9897e48f811bb8d494b734a87dab0d3968039c7; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_amd64.zip"; \
            SHA256=0e0fc38641addac17103122e1953a9afad764a90e74daf4ff8ceeba4e362f2fb; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_arm.zip"; \
            SHA256=647a69acf01b3cac829f4436e8095d927ee6732cd6c076e24674a3c09326aad2; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_arm.zip"; \
            SHA256=647a69acf01b3cac829f4436e8095d927ee6732cd6c076e24674a3c09326aad2; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_arm64.zip"; \
            SHA256=6da7bf01f5a72e61255c2d80eddeba51998e2bb1f50a6d81b0d3b71e70e18531; \
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

RUN apk add --no-cache ca-certificates

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
