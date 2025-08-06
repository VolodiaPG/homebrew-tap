cask "helium-chromium" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.15.1-138.0.7204.183"
  sha256 arm:   "74e1f648fa7071959803c6aafdf2bec17b1919f90428d0c058f8d34ca17e250d",
         intel: "f429831835608558e1020cbb91c80380ddec0ee213197c9913dca301cd54762a"

  url "https://github.com/imputnet/helium-macos/releases/download/#{version}/helium_#{version.sub(/-.+$/, "")}_#{arch}-macos.dmg"
  name "Helium"
  desc "Bullshit-free web browser, based on Chromium"
  homepage "https://github.com/imputnet/helium-macos"

  livecheck do
    url "https://github.com/imputnet/helium-macos/releases"
    regex(/^(\d+(?:\.\d+){3}-\d+(?:\.\d+){3})$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  conflicts_with cask: "chromium"
  depends_on macos: ">= :big_sur"

  app "Helium.app"

  zap trash: [
    "~/Library/Application Support/net.imput.helium",
    "~/Library/Caches/net.imput.helium",
    "~/Library/Preferences/net.imput.helium.plist",
  ]
end
