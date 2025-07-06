class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.37"
  sha256 "3404fd1da760cc206abacbad45690f6a60bd29ce176aa1871c0ce2605ff25755"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.37/gajevids_0.3.37_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
