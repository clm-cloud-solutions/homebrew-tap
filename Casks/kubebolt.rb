cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.2"
  sha256 arm:          "6408d1cc4910de159325ec3a52227a2aa21a668a1266b5d392da6a03eb57514d",
         intel:        "0c6f7447d2e97c47fbd532063c6623c4fa0bca225cd9da80c5b980bd5aeca07e",
         arm64_linux:  "3a0e7e1b002488c31866c2adc3c75e6c370070eb1d4692732a4e4782d3a29758",
         x86_64_linux: "1c0f112e870c8f573d70449a3ace1f53ec51e2b56b8df77953266e63ed19cf0b"

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
