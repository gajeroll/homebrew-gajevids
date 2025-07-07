class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.38"
  sha256 "ba9a90dbc82646cd37df0c52b60198c4018d012b4f7af1583071ca4439893aea"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.38/gajevids_0.3.38_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
