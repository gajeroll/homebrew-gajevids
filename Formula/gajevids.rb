class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  version "0.3.41"
  sha256 "ae7aa38faad5c7866d4430cc3e98cf27be63c3c62032b27c44efb162cf56db2e"

  url "https://github.com/gajeroll/homebrew-gajevids/releases/download/v0.3.41/gajevids_0.3.41_darwin_arm64.tar.gz"

  def install
    bin.install "gajevids"
  end

  test do
    system "#{bin}/gajevids", "--version"
  end
end
