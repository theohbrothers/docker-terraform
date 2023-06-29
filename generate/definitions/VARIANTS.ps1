# Docker image variants' definitions
$local:VARIANTS_MATRIX = @(
    @{
        package = 'terraform'
        package_version = '1.3.4-r4'
        distro = 'alpine'
        distro_version = '3.17'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ); tag_as_latest = $true }
            @{ components = @( 'jq', 'libvirt', 'sops', 'ssh' )}
        )
    }
    @{
        package = 'terraform'
        package_version = '1.2.0-r4'
        distro = 'alpine'
        distro_version = '3.16'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '1.0.11-r2'
        distro = 'alpine'
        distro_version = '3.15'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.14.9-r4'
        distro = 'alpine'
        distro_version = '3.14'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.14.4-r0'
        distro = 'alpine'
        distro_version = '3.13'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.12.25-r0'
        distro = 'alpine'
        distro_version = '3.12'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.12.17-r1'
        distro = 'alpine'
        distro_version = '3.11'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.12.6-r0'
        distro = 'alpine'
        distro_version = '3.10'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.11.8-r0'
        distro = 'alpine'
        distro_version = '3.9'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.11.7-r0'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.11.0-r0'
        distro = 'alpine'
        distro_version = '3.7'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.9.5-r0'
        distro = 'alpine'
        distro_version = '3.6'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.8.1-r0'
        distro = 'alpine'
        distro_version = '3.5'
        subvariants = @(
            @{ components = @( 'jq', 'sops', 'ssh' ) }
        )
    }
)
$VARIANTS = @(
    foreach ($variant in $VARIANTS_MATRIX){
        foreach ($subVariant in $variant['subvariants']) {
            @{
                # Metadata object
                _metadata = @{
                    package = $variant['package']
                    package_version = $variant['package_version']
                    package_version_semver = "v$( $variant['package_version'] )" -replace '-r\d+', ''   # E.g. Strip out the '-r' in '2.3.0.0-r1'
                    distro = $variant['distro']
                    distro_version = $variant['distro_version']
                    platforms = & {
                        if ($variant['distro'] -eq 'alpine') {
                            $v = $variant['distro_version'] -as [version]
                            if ($v.Major -eq 3 -and $v.Minor -ge 3 -and $v.Minor -le 5) {
                              'linux/amd64'
                            }elseif ($v.Major -eq 3 -and $v.Minor -ge 6 -and $v.Minor -le 13) {
                              'linux/386,linux/amd64,linux/arm64,linux/s390x'
                            }elseif ($v.Major -eq 3 -and $v.Minor -ge 14) {
                              'linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/s390x'
                            }else {
                                throw 'Invalid alpine version'
                            }
                        }
                    }
                    components = $subVariant['components']
                }
                # Docker image tag. E.g. 'v2.3.0.0-alpine-3.6'
                tag = @(
                        "v$( $variant['package_version'] )" -replace '-r\d+', ''    # E.g. Strip out the '-r' in '2.3.0.0-r1'
                        $subVariant['components'] | ? { $_ }
                        $variant['distro']
                        $variant['distro_version']
                ) -join '-'
                tag_as_latest = if ( $subVariant.Contains('tag_as_latest') ) {
                    $subVariant['tag_as_latest']
                } else {
                    $false
                }
            }
        }
    }
)

# Docker image variants' definitions (shared)
$VARIANTS_SHARED = @{
    buildContextFiles = @{
        templates = @{
            'Dockerfile' = @{
                common = $true
                includeHeader = $false
                includeFooter = $false
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
        }
    }
}
