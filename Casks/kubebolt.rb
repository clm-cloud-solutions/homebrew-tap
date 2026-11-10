cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.0"
  sha256 arm:          "dd70674a0a7a855340f040bc16b210ee62f42f071d88e2a1e582b6e069275a18",
         intel:        "659db444e9f856f3a2100b50c3bea99ba6f3ca57501ba3ecf2a88c6b6da8e10d",
         arm64_linux:  "98b4c8a7b321ed37e79a47eea3375ff5305bdb0976ddd593f912a86f934a71c2",
         x86_64_linux: "0122bef85e5b401feb24459dc350028594823f38c0a044dc4f6ed3c97daea012"

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
