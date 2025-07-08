class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.43"
  sha256 "8666b4f333b022cdeac3167406adf07e0c28c63bb68739a8b6ffbc3ac220b559"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.43/gajevids_0.3.43_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
