class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.35"
  sha256 "74972cc6876c0dd8c553d5d904154290599d10042857913f23e4342437e7979e"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.35/gajevids_0.3.35_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
