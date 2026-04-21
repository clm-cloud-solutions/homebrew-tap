# This is the TEMPLATE used by the release workflow.
# The actual formula lives in the homebrew-tap repository:
#   https://github.com/clm-cloud-solutions/homebrew-tap/blob/main/Formula/kubebolt.rb
#
# On each release, the workflow:
#   1. Downloads the binaries
#   2. Computes SHA256 for each
#   3. Replaces 1.5.0-rc.1 / __SHA_*__ placeholders
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
  version "1.5.0-rc.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-arm64"
      sha256 "6f0ef38fbd0475c2295a1808ae759ff04fea1059ac5b4c6daec2464e4b0fadf0"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-amd64"
      sha256 "4e0f4fdd4b9b0cd5261698718019057a9476e66e733ee06f271b10a4237ed517"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-arm64"
      sha256 "f839c674c69372fd5dbb5f3dd758874d450b12e655a3c8c448e3033c279e13d0"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-amd64"
      sha256 "6da1a3192de8260155ef2592b314ce1e3998f7ef4829ad91a51cc9cb71fef438"
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
