cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.1"
  sha256 arm:          "3eac1d0105efaa90adbdb956314c738600b241fe09494e37df4e7ead4b8e96fd",
         intel:        "8e803b271e9a84ec549cdcde250f75f5edc57e7a9dcb5ec2a39f109de99a2f6f",
         arm64_linux:  "62da25d13707cac9a745b5bbf4ce13f3fc2519d96c8b331b60021a4bdd72e7e3",
         x86_64_linux: "6c4e336633412653451b4df27783495b92112bcaa6e209437290e7b2071060d3"

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
