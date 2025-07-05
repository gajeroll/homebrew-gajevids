class Gajevids < Formula
  VERSION = "v0.2.10"
  desc     "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  url      "https://github.com/gajeroll/homebrew-gajevids/archive/refs/tags/#{VERSION}.tar.gz"
  sha256   "effe81d5d88579ff1a31dbe20f5f156aa1982937e1412d71b3e04e7687754646"
  license  "MIT"
  head     "https://github.com/gajeroll/homebrew-gajevids.git", branch: "main"

  depends_on "ffmpeg"
  depends_on "yq"

  def install
    bin.install "dist/gajevids"
    bin.install "dist/gajevids-go"
  end

  test do
    assert_match "gajevids", shell_output("#{bin}/gajevids --version")
  end
end
