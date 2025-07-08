class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.42"
  sha256 "51b178d2b736e51d5cba19b36b2904397148dc10e78c4f4d53eefa01774c648e"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.42/gajevids_0.3.42_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
