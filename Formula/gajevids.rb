class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.48"
  sha256 "6d4a0264a8e1c310d0fb8ab32dd7e2d37b70687c62a8af2f50faa9a8dead31b0"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.48/gajevids_0.3.48_darwin_arm64.tar.gz"

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
