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
    # platforms = $VARIANT['_metadata']['platforms']
    destination = '/usr/local/bin/terraform'
    testCommand = 'CHECKPOINT_DISABLE=1 terraform version'
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
    $SOPS_VERSION = "3.13.3"
    Generate-DownloadBinary @{
        binary = 'sops'
        version = $SOPS_VERSION
        checksumsUrl = "https://github.com/getsops/sops/releases/download/v$SOPS_VERSION/sops-v$SOPS_VERSION.checksums.txt"
        platformFallback = 'linux/amd64'
        destination = '/usr/local/bin/sops'
        testCommand = 'sops --version --disable-version-check'
    }

    @"
# Install gnupg for sops
RUN apk add --no-cache gnupg


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'ssh' ) {
    @"
RUN apk add --no-cache openssh-client sshpass


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'step' ) {
    $STEP_VERSION = "v0.27.5"
    Generate-DownloadBinary @{
        binary = 'step'
        version = $STEP_VERSION
        checksumsUrl = "https://github.com/smallstep/cli/releases/download/$STEP_VERSION/checksums.txt"
        archiveformat = '.tar.gz'
        # platforms = $VARIANT['_metadata']['platforms']
        destination = '/usr/local/bin/step'
        testCommand = 'step version'
    }
}

@"
CMD [ "terraform" ]

"@
