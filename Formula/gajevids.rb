class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.47"
  sha256 "b22dc924a903754588e08ebb544d36857fca99b4318ab56f9e86a2a6ad976bf5"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.47/gajevids_0.3.47_darwin_arm64.tar.gz"

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
