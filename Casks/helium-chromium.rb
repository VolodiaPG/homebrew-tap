cask "helium-chromium" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.9.1"
  version_chromium = "138.0.7204.100"
  sha256 arm:   "4cfcde22cc8826ea1b50848cc1aaecf162d69e729b1474bc4a81376c933faf6b",
         intel: "e179ba763a588f8590986577392bb9e54cf2d088631ec440a5cf5cebf272a78b"

  name "Helium"
  desc "Bullshit-free web browser, based on Chromium."
  homepage "https://github.com/imputnet/helium-macos"

  url "https://github.com/imputnet/helium-macos/releases/download/#{version}/helium_#{version}-#{version_chromium}_#{arch}-macos.dmg"

  livecheck do
    url :url
    regex(/^(\d+(?:[.-_]\d+)+)(?:[._-]#{arch})?(?:[._-]+?(\d+(?:\.\d+)*))?$/i)
    strategy :github_latest do |json, regex|
      match = json["tag_name"]&.match(regex)
      next if match.blank?

      match[1]
    end
  end

  conflicts_with cask: "chromium"
  depends_on macos: ">= :big_sur"

  app "Helium.app"  # Adjust if the bundle name is different

  zap trash: [
    "~/Library/Application Support/net.imput.helium",
    "~/Library/Caches/net.imput.helium",
    "~/Library/Preferences/net.imput.helium.plist",
  ]
end
