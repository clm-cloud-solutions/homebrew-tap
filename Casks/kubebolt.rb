cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.4"
  sha256 arm:          "412ccef6b98f3c2be759834b6b23f57f8621cd5a675d60ca552e1f2510dbbde0",
         intel:        "3cb2ab4c2a3b1820ae1cbf7d82e693a9b862f783181418bca558d98465fd3753",
         arm64_linux:  "9f28935bbfe764c6e32a5d41d74ea8667a2df2ec596bb779525d3da400b2eb7d",
         x86_64_linux: "2bdc2db11366c8cdf6d0e281cafd3c9e244e026875ddf26261db7c099cd856a2"

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
