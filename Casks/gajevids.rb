cask "gajevids" do
  version "0.3.33"
  sha256 "bef581465c24979eadb38b4a7765c662c6d56c4f7b546b64ae24b4a871d4f844"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.33/gajevids.app.zip",
      verified: "github.com/gajeroll/homebrew-gajevids"
  name "gajevids"
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/gajevids"

  app "gajevids.app"

  caveats <<~EOS
    If you see a security warning, run:
      sudo xattr -dr com.apple.quarantine /Applications/gajevids.app
  EOS
end
