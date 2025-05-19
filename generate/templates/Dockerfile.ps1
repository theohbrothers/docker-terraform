@"
FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1


"@

Generate-DownloadBinary @{
    binary = 'terraform'
    version = $VARIANT['_metadata']['package_version']
    checksumsUrl = "https://releases.hashicorp.com/terraform/$( $VARIANT['_metadata']['package_version'] )/terraform_$( $VARIANT['_metadata']['package_version'] )_SHA256SUMS"
    archiveformat = '.zip'
    destination = '/usr/local/bin/terraform'
    testCommand = 'CHECKPOINT_DISABLE=1 terraform version'
}

$STEP_VERSION = "v0.27.5"
Generate-DownloadBinary @{
    binary = 'step'
    version = $STEP_VERSION
    archiveformat = '.tar.gz'
    archivefiles = @()
    checksumsUrl = "https://github.com/smallstep/cli/releases/download/$STEP_VERSION/checksums.txt"
    destination = '/usr/local/bin/step'
    testCommand = 'step version'
}

if ( $VARIANT['_metadata']['components'] -contains 'jq' ) {
    @"
RUN apk add --no-cache jq


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'libvirt' ) {
    @"
RUN apk add --no-cache libvirt-client


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'sops' ) {
#     if ( $VARIANT['_metadata']['distro'] -eq 'alpine' -and $VARIANT['_metadata']['distro_version'] -in @('3.6', '3.5', '3.4', '3.3') ) {
# @"
# # Fix generic certification validation errors in alpine 3.5: https://github.com/docker-library/official-images/issues/2773#issuecomment-350431934
# RUN apk add --no-cache ca-certificates

# # Fix wget not working in alpine:3.6 and below. https://github.com/gliderlabs/docker-alpine/issues/423
# # RUN apk add --no-cache libressl

# # Fix wget error 'wget: SSL/TLS certificate is not being validated!' in alpine:3.5, use curl instead: https://github.com/docker-library/official-images/issues/2773
# RUN set -eux; \
#     apk add --no-cache curl; \
#     curl -sSL https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
#     chmod +x /usr/local/bin/sops; \
#     sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
#     sops --version; \
#     apk del curl

# RUN apk add --no-cache gnupg


# "@
#     }else {
@"
RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg


"@
    # }
}

if ( $VARIANT['_metadata']['components'] -contains 'ssh' ) {
    @"
RUN apk add --no-cache openssh-client sshpass


"@
}

@"
CMD [ "terraform" ]

"@
