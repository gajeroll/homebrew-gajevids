class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.45"
  sha256 "2c42366ae12d5d732d62c9419c5789eecff7c1ca09fe808279d1e293520252a9"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.45/gajevids_0.3.45_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"

    bash_completion.install "gajevids.bash"
    zsh_completion.install "_gajevids"
    fish_completion.install "gajevids.fish"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
