FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.7.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_linux_386.zip"; \
            SHA256=22d76bf46f743d335501a538931924cd0c259f682b3e84ab638f4ed7b113f81e; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_linux_amd64.zip"; \
            SHA256=617042989ce46b5dd07772237b49b57b8f8e97b1604c9dbbd85ead87effb51fe; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_linux_arm.zip"; \
            SHA256=1a738382f1b9d1fd5238e1408db939768ce5ee9d5d2c6e0db1f29a68690afea4; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_linux_arm.zip"; \
            SHA256=1a738382f1b9d1fd5238e1408db939768ce5ee9d5d2c6e0db1f29a68690afea4; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_linux_arm64.zip"; \
            SHA256=e9a8a2f676b51a5334d00a0c3695b24ca75e30f4f449eb191e304fedfa099565; \
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
