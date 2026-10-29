cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.5.1"
  sha256 arm:          "550adfc7dcb5ea7d317543c38763183d520a2b5813c634dcb483f523f37d196e",
         intel:        "d6ee64b7eeb9bcdb4c1d86eb8e6ad20e34aa7c3161e66fb2ee0df4b5d6748fb7",
         arm64_linux:  "c54314b1f3426399ade3e8d4da7e8d7038ddb6154d7cd801c5600d9dc36b1ba8",
         x86_64_linux: "8edafc26ac959cf6359b3a10b6262fa0d697b6cfa2ed27688caf35cf0d1de56b"

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
