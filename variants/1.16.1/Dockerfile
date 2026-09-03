FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.16.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_linux_386.zip"; \
            SHA256=6c2bca9259f64e8ea1da236f3db7f474266141f2b50dbf75594b84a784547d3d; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_linux_amd64.zip"; \
            SHA256=745d33b4b02b7980c62a38ec1beea24ee084ea8caf3f503c200554bd9a0cbe49; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_linux_arm.zip"; \
            SHA256=d60ad6dfa813ea89470ad1ea2f54776e5b4a6c1687161957158c718a60a14020; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_linux_arm.zip"; \
            SHA256=d60ad6dfa813ea89470ad1ea2f54776e5b4a6c1687161957158c718a60a14020; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_linux_arm64.zip"; \
            SHA256=423288a23ab024d42ac05c409972585f7ec0cf1be572b773ad952f9a1c41387d; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.16.1/terraform_1.16.1_linux_s390x.zip"; \
            SHA256=5cdf70c8950441aa9d80ec3c4a6608a2844c6b5b71acc92fb05e35f1019c0331; \
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
