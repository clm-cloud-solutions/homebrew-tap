# This is the TEMPLATE used by the release workflow.
# The actual formula lives in the homebrew-tap repository:
#   https://github.com/clm-cloud-solutions/homebrew-tap/blob/main/Formula/kubebolt.rb
#
# On each release, the workflow:
#   1. Downloads the binaries
#   2. Computes SHA256 for each
#   3. Replaces 1.13.0 / __SHA_*__ placeholders
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
  version "1.13.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-arm64"
      sha256 "985454d824a115fa0016f24f621376bde43cde67334ec30fc806656afd2ff2c8"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-darwin-amd64"
      sha256 "ada0ca5c84b3caa157e1d1f01e07c0b4df4d10c8b8bdd5e5fca28b48029addaf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-arm64"
      sha256 "a20f2e8961e6493d460a30598980c9853a86f15cf2ec4136cfcf62a2ce7e46e7"
    end
    on_intel do
      url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-linux-amd64"
      sha256 "9da53f46f1286040aa602c44b634787ce19da5ec9312e407fb3767998b2655a7"
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
