# This is the TEMPLATE used by the release workflow.
# The actual formula lives in the homebrew-tap repository:
#   https://github.com/clm-cloud-solutions/homebrew-tap/blob/main/Formula/kubebolt.rb
#
# On each release, the workflow:
#   1. Downloads the binaries
#   2. Computes SHA256 for each
#   3. Replaces 1.11.0 / __SHA_*__ placeholders
#   4. Commits the updated formula to the tap repo
#
# User-facing install:
#   brew install clm-cloud-solutions/tap/kubebolt
#
# Setup required (one time, manual):
#   1. Create github.com/clm-cloud-solutions/homebrew-tap (public repo)
#   2. Create a personal access token with `repo` scope
#   3. Add it as HOMEBREW_TAP_TOKEN secret in this repo's settings
#   4. The update-homebrew-tap job in release.yml handles the rest
class Kubebolt < Formula
  desc "Instant Kubernetes monitoring and management — full cluster visibility in under 2 minutes"
  homepage "https://github.com/clm-cloud-solutions/kubebolt"
  version "1.11.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-arm64"
      sha256 "8962abd77ba83e459305ca3208c779cfdba9da349bfbc092f47539403810d3ac"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-amd64"
      sha256 "9ebd1d783db4e165fa4144758f851e3e45370b87973528261677fb26b0596ff0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-arm64"
      sha256 "9cb3921f4fe6a411229f3c8eafa3be3132ed03b0fb6f0bd97e39bba6376effec"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-amd64"
      sha256 "7862f1f4ddee0017f0b546a5a625691c88eccf064c25a125c838efe4114bc07e"
    end
  end

  def install
    # Homebrew downloads the file as-is, so we rename to 'kubebolt' on install
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "kubebolt-#{os}-#{arch}" => "kubebolt"
  end

  test do
    output = shell_output("#{bin}/kubebolt --version")
    assert_match "KubeBolt", output
  end
end
