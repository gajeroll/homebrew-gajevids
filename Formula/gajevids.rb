class Gajevids < Formula
  VERSION = "v0.1.7"
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  url "https://github.com/gajeroll/homebrew-gajevids/archive/refs/tags/#{VERSION}.tar.gz"
  sha256 "6898ea5ecf64b1167d4881f8b748b6178d80a011861ae5e509f3ea9ae1488425"
  license "MIT"
  head "https://github.com/gajeroll/homebrew-gajevids.git", branch: "main"

  depends_on "go" => :build
  depends_on "ffmpeg"
  depends_on "yq"

  def install
    # Install prebuilt Go binary
    bin.install "bin/gajevids"

    # Install documentation
    doc.install "README.md"
  end

  test do
    # Test version output
    assert_match "gajevids #{VERSION}", shell_output("#{bin}/gajevids --version")
    
    # Test help output
    assert_match "YAML-based FFmpeg video composition tool", shell_output("#{bin}/gajevids --help")
    
    # Test example file creation
    system "#{bin}/gajevids", "--example"
    assert_predicate testpath/"gajevids_example.yml", :exist?
  end
end 