cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.7.0"
  sha256 arm:          "04b51838b6e13ccf6b150549b0a935c0c35c2cda1b0b28a77b48a61cf771a5a7",
         intel:        "3f04f3841dbe2c2aed9521786fcdc26be932fb4d46e04aaa70e0ab9dba232527",
         arm64_linux:  "ddf26e3cc798f8df9aa68f63d5fb5e93e4ec5abaa190cb89717e0fbc2377710f",
         x86_64_linux: "619a4773accf2c28ed94440fe4a829f2a5a2370c25ca6acf39943720e8f29242"

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
