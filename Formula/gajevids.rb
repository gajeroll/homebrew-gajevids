class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.39"
  sha256 "1d899c375fd9e8a6a376ce315e4d3676c875f68f17a9816d62a27b49be01d6c9"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.39/gajevids_0.3.39_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
