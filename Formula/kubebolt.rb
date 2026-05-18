# This is the TEMPLATE used by the release workflow.
# The actual formula lives in the homebrew-tap repository:
#   https://github.com/clm-cloud-solutions/homebrew-tap/blob/main/Formula/kubebolt.rb
#
# On each release, the workflow:
#   1. Downloads the binaries
#   2. Computes SHA256 for each
#   3. Replaces 1.10.1 / __SHA_*__ placeholders
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
  version "1.10.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-arm64"
      sha256 "f08d6c265c3736ef84d10f078016a06436639eb4198caf241f95ccb1a2ea26ee"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-amd64"
      sha256 "4a8a690b59a0bd1559150085234c1e2e99f9ac7b918a441a795abab794432df6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-arm64"
      sha256 "58a0637a68f9d162d7b294b69377b148c237c781ba0f57b27f8f1b4469254055"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-amd64"
      sha256 "dddb9ba3f3b0184f992c09adf080b657528c90d34d137a35e16eefffc69cac96"
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
