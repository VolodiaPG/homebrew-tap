cask "helium-chromium" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.4.1-139.0.7258.138"
  sha256 arm:   "da5dfb21087aa24e72d9f9169019773dae6c2468236645e28e722c146ecd2566",
         intel: "82ad9162768e904de2d25a8e40f0600e6cbb62804b221d93e4db5e876b04079f"

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
