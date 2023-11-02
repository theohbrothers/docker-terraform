FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.6.3; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_386.zip; \
            SHA256=7729929560a752762abb45ee528321d34a21e6e26f18679d9a1d83a307481b80; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip; \
            SHA256=caa432f110db519bf9b7c84df23ead398e59b6cc3da2938f010200f1ee8f2ae4; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_arm.zip; \
            SHA256=e180ff62badecbf4e0a4f71d628812d73981bab650533b0c2facb2bc10d9ccac; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_arm.zip; \
            SHA256=e180ff62badecbf4e0a4f71d628812d73981bab650533b0c2facb2bc10d9ccac; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_arm64.zip; \
            SHA256=01d8dc9bda3d4de585d5901c5099d9155faeb0730fbd9dc6c6e13735cba76700; \
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

RUN apk add --no-cache jq

RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
