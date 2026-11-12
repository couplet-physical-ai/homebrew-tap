cask "switchyard" do
  version "0.1.6"
  sha256 "2483b30a383343405ddc5b4f3ead7fcc1604e781b052794883927c9dd4873772"

  url "https://github.com/couplet-physical-ai/switchyard/releases/download/v#{version}/Switchyard-#{version}-arm64.zip"
  name "Switchyard"
  desc "Live control room for a whole CI/CD fleet: commits, pipelines, PRs, deploys, health"
  homepage "https://github.com/couplet-physical-ai/switchyard"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself in place (Update button, latest.json feed), so `brew upgrade`
  # leaves it alone unless asked with --greedy; brew still installs the newest on a fresh install.
  auto_updates true

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
    It updates itself (Update in the app); `brew upgrade --cask --greedy switchyard` also works.
  CAVEATS
end
