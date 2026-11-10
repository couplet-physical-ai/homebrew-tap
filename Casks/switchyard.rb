cask "switchyard" do
  version "0.0.2"
  sha256 "bd3aeccc1f40ee0e173fa3d3683fcf01bac4b5b39055789496cf353da108a340"

  url "https://github.com/couplet-physical-ai/switchyard/releases/download/v#{version}/Switchyard-#{version}-arm64.zip"
  name "Switchyard"
  desc "Live control room for a whole CI/CD fleet: commits, pipelines, PRs, deploys, health"
  homepage "https://github.com/couplet-physical-ai/switchyard"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Switchyard.app"

  # Ad-hoc signed (no Developer ID): drop the download quarantine so Gatekeeper lets it open.
  # `postflight_steps` (Homebrew >= 7.0.6), not the `postflight` block Homebrew 7 deprecates.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Switchyard.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.exowatt.switchyard",
    "~/Library/Caches/com.exowatt.switchyard",
    "~/Library/Preferences/com.exowatt.switchyard.plist",
    "~/Library/Saved Application State/com.exowatt.switchyard.savedState",
  ]

  caveats <<~CAVEATS
    Switchyard connects to https://switchyard.apps.example.com (Exowatt SSO).
    The app is ad-hoc signed; this cask removes the quarantine flag on install.
  CAVEATS
end
