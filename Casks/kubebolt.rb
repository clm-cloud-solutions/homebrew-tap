cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.6"
  sha256 arm:          "3d907c77ece96e87570653805ca23e0b88d3fc5070cabe37e4cf92855f3e092b",
         intel:        "0f8243aa19726082dba0e88f16c9e21a539eac4978c58c0f0199e1a71f1c1b28",
         arm64_linux:  "1c24e522d769862033e4e8ba494e104194dbb3d4895608b2e34901b7132969ee",
         x86_64_linux: "fbcc3532f329760b6568da749a94bcf7d52f2109c3cf98bb8213e7583feeafd0"

  url "https://github.com/clm-cloud-solutions/kubebolt/releases/download/v#{version}/kubebolt-#{os}-#{arch}"
  name "KubeBolt"
  desc "Kubernetes operations platform: health, insights, operations, security, cost"
  homepage "https://github.com/clm-cloud-solutions/kubebolt"

  binary "kubebolt-#{os}-#{arch}", target: "kubebolt"

  # The macOS binary is not notarized: once Homebrew quarantines the download,
  # macOS would kill it on first run.
  postflight_steps do
    on_macos do
      run "/usr/bin/xattr",
          args:         ["-d", "com.apple.quarantine", "{{staged_path}}/kubebolt-darwin-{{arch}}"],
          must_succeed: false
    end
  end
end
