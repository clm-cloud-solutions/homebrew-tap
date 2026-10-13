cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.4.0"
  sha256 arm:          "e579f4a7dfcf401f2eba8634eff995345530fe8601d6b628509e99ef8b1537ff",
         intel:        "35ed2ed42e33f1d12754241414e3dd18e25a8252fe0f4b00079dcce1aced2be7",
         arm64_linux:  "2f333436057e73a3305339b44e128a52819057aa1c6d2eb73119c64ea5895749",
         x86_64_linux: "738f6b705eeac0e245e75ed31ecfac300e82c112bab845ff1bd0558ea849d1d0"

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
