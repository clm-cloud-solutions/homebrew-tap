cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.4.1"
  sha256 arm:          "eae840f547fefa769592e648eb0e510d499c4df2f3888a1d87b3bfc8c1794b6e",
         intel:        "7aa3395df7f4c019e1c5552af6d499900c0d972af1ca0f2952059e98e6e88d57",
         arm64_linux:  "8f82427f61ea608e0c75e8f288262d43c9db09d5e56cacdbab6ca691a4aa0a1e",
         x86_64_linux: "195bc4a43bfdd5476bc0e03b25169a312080ee6b4f6995056ec6d03e471a1dd4"

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
