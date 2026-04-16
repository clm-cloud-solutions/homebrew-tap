# CLM Cloud Solutions Homebrew Tap

Homebrew tap for CLM Cloud Solutions open-source products.

## Available Formulas

### KubeBolt

Instant Kubernetes monitoring and management — full cluster visibility in under 2 minutes.

```bash
brew install clm-cloud-solutions/tap/kubebolt
kubebolt --kubeconfig ~/.kube/config
```

- **Website:** https://clm-cloud-solutions.github.io/kubebolt/
- **Repository:** https://github.com/clm-cloud-solutions/kubebolt
- **License:** MIT

## Usage

```bash
# One-time: add the tap
brew tap clm-cloud-solutions/tap

# Install a formula
brew install kubebolt

# Update all formulas from this tap
brew upgrade
```

## How this tap works

Formulas in this repository are **automatically generated** by release workflows
in the upstream project repositories. Each formula points to platform-specific
binaries published on GitHub Releases with verified SHA256 checksums.

Do not edit formulas manually — changes will be overwritten on the next release.

## Support

Open issues in the specific product repository:

- KubeBolt issues: https://github.com/clm-cloud-solutions/kubebolt/issues
