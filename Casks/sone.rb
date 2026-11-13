cask "sone" do
  version "0.24.0"
  sha256 "11b42a4b66512e531ad6eab0cc9b83c51d0cb152ef5f07615356307e361402b5"

  url "https://github.com/VolodiaPG/sone/releases/download/v#{version}/SONE_#{version}_aarch64.dmg"
  name "SONE"
  desc "Native desktop client for TIDAL"
  homepage "https://github.com/VolodiaPG/sone"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  # The app links to the Homebrew GStreamer libraries at run time.
  depends_on formula: "gstreamer"
  depends_on :macos

  app "SONE.app"

  # The app is not signed or notarized, so Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "SONE.app"],
        chdir:          "{{appdir}}",
        writable_paths: ["{{appdir}}/SONE.app"]
  end

  zap trash: [
    "~/Library/Application Support/io.github.lullabyX.sone",
    "~/Library/Application Support/sone",
    "~/Library/Caches/io.github.lullabyX.sone",
    "~/Library/Caches/sone",
    "~/Library/HTTPStorages/sone.binarycookies",
    "~/Library/WebKit/io.github.lullabyX.sone",
    "~/Library/WebKit/sone",
  ]
end
