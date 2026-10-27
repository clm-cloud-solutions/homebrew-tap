cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.5.0"
  sha256 arm:          "481733bc15649923b48223805371b9f52632244fa741d407cf7330aadcbbe591",
         intel:        "4da12ce02384a8230d038e91099b9fa76aa071e5486a20ae46b7f52f1eb1b2bc",
         arm64_linux:  "e11f319620d7a9832b8a716f25f3d39c92817efdd28f281d71b753edf0781187",
         x86_64_linux: "f7b9a8d9e7849a044d2755087dee6f1d654ad0a0b50501f51443dec0f7804bdf"

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
