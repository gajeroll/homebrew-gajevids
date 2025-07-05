class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  url "https://github.com/gajeroll/homebrew-gajevids/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "d852d1d8c0f2228ae75460c15764b254edf826f281c12656655a97cf150c3e80"
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
    assert_match "gajevids v0.1.6", shell_output("#{bin}/gajevids --version")
    
    # Test help output
    assert_match "YAML-based FFmpeg video composition tool", shell_output("#{bin}/gajevids --help")
    
    # Test example file creation
    system "#{bin}/gajevids", "--example"
    assert_predicate testpath/"gajevids_example.yml", :exist?
  end
end 