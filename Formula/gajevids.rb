class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.44"
  sha256 "5faa68175e23d11bec4e11eeb6b363d439c6d159cdcf44c130ab8d90d9552999"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.44/gajevids_0.3.44_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
