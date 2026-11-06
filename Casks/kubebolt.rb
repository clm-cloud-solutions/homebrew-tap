cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.5.2"
  sha256 arm:          "34817c18b0223c27fd23ab0936ff61a6dda9cf89ce60dfc5bf2b984a690d6cd0",
         intel:        "ec470872dee0c07e98300f9d04d156e2e542d71349b992e327c7e80348056cf9",
         arm64_linux:  "3995d339d2cd8934c1252277dc17fcda7fa21e8dba32d6402125482402e5361f",
         x86_64_linux: "71ddadac9b95f24b1d1a39a31e697a7667b92aabc7f2705840e350644c7ea21f"

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
