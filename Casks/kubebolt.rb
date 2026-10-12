cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.3.1"
  sha256 arm:          "da4fd98c465a6e2832b5b975d4903df4d496b55934abccdc3d89021dba08de63",
         intel:        "db425099261bca0ee597bc9d174547a7fb7b9ff05900d2263f42d52506390dfe",
         arm64_linux:  "a31a7889cb961dcdac9b506c42db550e7346c8465feb65f7747632570765df7c",
         x86_64_linux: "d77384007204443bf679e3e1d739a5b644903305196d908e3bd35956e6a83342"

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
