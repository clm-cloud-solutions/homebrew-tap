cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.3.0"
  sha256 arm:          "e9dc009b221c17470b2bed4f4b65bb417274a0eff9048119864e6d0704b0b59d",
         intel:        "c49a1cd943c827f32ce39bf05abea8f234f175f4408bffc9a0e4843c7c29e9d5",
         arm64_linux:  "1f36d63de73fdac07d1b7b2227abf86694e14fe0efdaf67a3ceb476eb87c5eaf",
         x86_64_linux: "ee41a12807e766c718d2d8547d770bbc332c82c5c1ab8f441bef51c423ac9905"

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
