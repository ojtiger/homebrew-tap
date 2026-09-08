cask "pounce" do
  version "0.9.3"
  sha256 "39fcb9b273f931cf2fd6607922e734112ceddf631c3816968454849e88f64daf"

  url "https://github.com/ojtiger/pounce/releases/download/v#{version}/Pounce-#{version}.zip"
  name "Pounce"
  desc "Moves notification banners to a glass card in the centre of the screen"
  homepage "https://github.com/ojtiger/pounce"

  depends_on macos: :sonoma

  app "Pounce.app"

  # Not notarised yet, so the download carries the quarantine flag and Gatekeeper would block the first
  # launch. Homebrew dropped --no-quarantine (4.7); this tap is our own, so the cask clears it itself.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Pounce.app"]
  end

  uninstall quit: "dev.tungsten.pounce"

  zap trash: [
    "~/Library/Logs/pounce.log",
    "~/Library/Preferences/dev.tungsten.pounce.plist",
  ]
end
