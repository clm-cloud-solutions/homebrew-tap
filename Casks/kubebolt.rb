cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.4.2"
  sha256 arm:          "58a4bb38faba3c712599289f830dd403eb2decd81f0127417fbbcdee23691421",
         intel:        "290201a184c613327fb3e3910fdc3712532c25b19e284505108d642f25442dfa",
         arm64_linux:  "ac3c58c9cdc9e089457fa056af5a22da764e0fa1ce699da4a39186a005542246",
         x86_64_linux: "38d011ac50ec9aa46cc66423afd5144ae99789b069a2894ae852bf18034ffb9c"

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
