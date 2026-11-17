cask "ansible-console" do
  version "0.1.2"
  sha256 "98430e63645be43cc73c3201284c63d9cd739ce286ce5db2a34cbc4b71a2f4cb"

  url "https://github.com/couplet-physical-ai/ansible-console/releases/download/v#{version}/Ansible-#{version}-arm64.zip"
  name "Ansible"
  desc "Realtime operations console"
  homepage "https://github.com/couplet-physical-ai/ansible-console"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself in place (Relaunch to update, latest.json feed), so `brew upgrade`
  # leaves it alone unless asked with --greedy; brew still installs the newest on a fresh install.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Ansible.app"

  # Ad-hoc signed (no Developer ID): drop the download quarantine so Gatekeeper lets it open.
  # `postflight_steps` (Homebrew >= 7.0.6), not the `postflight` block Homebrew 7 deprecates.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Ansible.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.exowatt.ansible",
    "~/Library/Caches/com.exowatt.ansible",
    "~/Library/Logs/Ansible",
    "~/Library/Preferences/com.exowatt.ansible.plist",
    "~/Library/Saved Application State/com.exowatt.ansible.savedState",
  ]

  caveats <<~CAVEATS
    Ansible connects to your team's server (single sign-on in the browser, then a device token).
    The app is ad-hoc signed; this cask removes the quarantine flag on install.
    It updates itself (Relaunch to update in the app); `brew upgrade --cask --greedy ansible-console` also works.
  CAVEATS
end
