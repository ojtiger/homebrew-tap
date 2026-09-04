cask "pounce" do
  version "0.2.9"
  sha256 "312ffb835eca1c7ce363c5fc6b4b40f4d848500178dadb8f2eba176e0b431e85"

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

  caveats do
    <<~EOS
      첫 실행 때 접근성 권한을 허용해야 카드가 뜹니다.
    EOS
  end
end
