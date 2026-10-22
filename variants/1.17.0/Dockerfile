FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.17.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.17.0/terraform_1.17.0_linux_386.zip"; \
            SHA256=1a00f265b74d27696ac8d3e76e17f4be330b9a052d5014db3a1184044ce223d1; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.17.0/terraform_1.17.0_linux_amd64.zip"; \
            SHA256=c168cab7c637a8769fdb90089ddd19de701bc6ff8aca64dc2e2185fe46f59f67; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.17.0/terraform_1.17.0_linux_arm.zip"; \
            SHA256=6afa19b6b59648160fb011f29994960efca87cba7cac3e5a86ca8df7be13019d; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.17.0/terraform_1.17.0_linux_arm.zip"; \
            SHA256=6afa19b6b59648160fb011f29994960efca87cba7cac3e5a86ca8df7be13019d; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.17.0/terraform_1.17.0_linux_arm64.zip"; \
            SHA256=f32478134ffc6d710eec474bbd316652cdddc0f4e336973a3745e8d3a3309cdf; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.17.0/terraform_1.17.0_linux_s390x.zip"; \
            SHA256=390c7741a01add4dd0c6b6cbae532609da1ce815ab108c8fda2861825eaf55b9; \
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
