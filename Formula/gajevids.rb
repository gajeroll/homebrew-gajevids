class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.36"
  sha256 "831d2347b5e983329ec8df771fb8fa9b10d5ae045cf41969b0a85100c1c1f379"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.36/gajevids_0.3.36_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
