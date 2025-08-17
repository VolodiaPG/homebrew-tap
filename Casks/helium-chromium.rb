cask "helium-chromium" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.3.1-139.0.7258.127"
  sha256 arm:   "07bac64039dfe9b5f8e8ef49a69905ddaf0f39bd2995b8afd7c30c9dc1a8f5db",
         intel: "23b169fc5b8a05a1a8fa36e938c81210954d63617f21bb8d27f19b85a9e7054a"

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
