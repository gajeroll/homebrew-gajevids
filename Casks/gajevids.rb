cask "gajevids" do
  version "0.3.32"
  sha256 "affede12b6e3fc164a4e82217bda85c0012af717e1eec4bd674fa85ca1320899"

  url "https://github.com/gajeroll/homebrew-gajevids/raw/release/v0.3.32/Artifacts/gajevids.app.zip",
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
