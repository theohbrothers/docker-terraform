# Docker image variants' definitions
$local:VARIANTS_MATRIX = @(
    @{
        package = 'terraform'
        package_version = '0.14.9-r2'
        distro = 'alpine'
        distro_version = '3.14'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh' ); tag_as_latest = $true }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.14.4-r0'
        distro = 'alpine'
        distro_version = '3.13'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.12.25-r0'
        distro = 'alpine'
        distro_version = '3.12'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.12.17-r1'
        distro = 'alpine'
        distro_version = '3.11'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.12.6-r0'
        distro = 'alpine'
        distro_version = '3.10'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.11.8-r0'
        distro = 'alpine'
        distro_version = '3.9'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.11.7-r0'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.11.0-r0'
        distro = 'alpine'
        distro_version = '3.7'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.9.5-r0'
        distro = 'alpine'
        distro_version = '3.6'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh' ) }
        )
    }
    @{
        package = 'terraform'
        package_version = '0.8.1-r0'
        distro = 'alpine'
        distro_version = '3.5'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh' ) }
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
