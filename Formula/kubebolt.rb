# This is the TEMPLATE used by the release workflow.
# The actual formula lives in the homebrew-tap repository:
#   https://github.com/clm-cloud-solutions/homebrew-tap/blob/main/Formula/kubebolt.rb
#
# On each release, the workflow:
#   1. Downloads the binaries
#   2. Computes SHA256 for each
#   3. Replaces 1.10.0-rc.2 / __SHA_*__ placeholders
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
  version "1.10.0-rc.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-arm64"
      sha256 "ca7baa260612f623f540223e1b72b56602525adb02e12f718e70c565b60170db"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-amd64"
      sha256 "9c60c0df24ddca40a720c94648df39e7f59066c93ca14cee900553ba9b2f7914"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-arm64"
      sha256 "bc085a60b24fa11758dd26b33edb5b237387fba0cba28a79ba7a2a318cd431c4"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-amd64"
      sha256 "640b44f2f080e6a238cf307c1689cde5a33328db2f4d21b8a0f513447b13e708"
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
