cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.5"
  sha256 arm:          "c38f179ec971c094f5e4d86e1df969baa54fef1e8b529f170cdfae11268316d7",
         intel:        "e72e5109a5b1f97c427ec8594a3e2bd5255f40de42687a876a3494ccb1c644b6",
         arm64_linux:  "f5d193cc129217d8417e8924b5b358f59f95901ca99b2b0e044ab428bb0437d7",
         x86_64_linux: "9df2530b819812862e7bc0669247e9be19ecc89c48f8a997d93321c15092be70"

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
