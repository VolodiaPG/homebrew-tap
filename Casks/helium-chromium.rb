cask "helium-chromium" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.14.1-138.0.7204.183"
  sha256 arm:   "8d8bea06a47a7b25ebf2a6c8688fd51d184c9497a039f10908f680962415e7e3",
         intel: "ec980ddb66385ebdcdde570375b6e592e3ad2a59dd79d1751c3b4d03a3b9ace6"

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
