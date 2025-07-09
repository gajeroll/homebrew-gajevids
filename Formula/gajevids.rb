class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.46"
  sha256 "c565b50d2e10edd6e8e3bd11d723477a75a847e6258927622b1585dc2ffa2980"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.46/gajevids_0.3.46_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"

    bash_completion.install "gajevids.bash" if File.exist?("gajevids.bash")
    zsh_completion.install "_gajevids" if File.exist?("_gajevids")
    fish_completion.install "gajevids.fish" if File.exist?("gajevids.fish")
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
