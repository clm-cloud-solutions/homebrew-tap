cask "kubebolt" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "2.6.7"
  sha256 arm:          "195d91cfee04a885bec45611eaab279c86bd5fd340621d4b1d9d51ec6a286412",
         intel:        "9d478545b1217f4eb80183eb1f1eccd4efc506ef40d23a594ae3c1c479855f65",
         arm64_linux:  "11776937970da7c360ce2e9cd54311bd67f624c195e72cb348a28bfdcfc442a5",
         x86_64_linux: "0852452dd0417582e3fa02f7fcffa890054bc25fd6a5c8fc1030df88f8e6c726"

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
