cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.3"
  sha256 arm:          "b2bfc9514c72ef8c8bd307b7d1248105477152453ea2ab6708978c03d0ff6892",
         intel:        "b601fcd2bb529dd70ee5506c42d32710d0158c7c28129730b9df30c5ff9a8abd",
         arm64_linux:  "6d12fba81f5f9f1bf7e612d71f9b71bd5b49c702ca77df7694f26422773dbec8",
         x86_64_linux: "97a2427d76a81e9a44d5556d16aad4723aeb3a54d6cbbeac89faf07ef021ebfb"

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
