class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  url "https://github.com/gajeroll/homebrew-gajevids/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "28e5f4fe7f601552779d935f8b5a6ab967d0702e753c30c32dbd64731be7f1c7"
  license "MIT"
  head "https://github.com/gajeroll/homebrew-gajevids.git", branch: "main"

  depends_on "go" => :build
  depends_on "ffmpeg"
  depends_on "yq"

  def install
    # Build Go binary
    cd "go" do
      system "go", "build", "-o", "gajevids-go", "./cmd/composer"
      bin.install "gajevids-go"
    end

    # Install main script
    bin.install "gajevids"

    # Install documentation
    doc.install "README.md"
  end

  test do
    # Test version output
    assert_match "gajevids v0.1.5", shell_output("#{bin}/gajevids --version")
    
    # Test help output
    assert_match "YAML-based FFmpeg video composition tool", shell_output("#{bin}/gajevids --help")
    
    # Test example file creation
    system "#{bin}/gajevids", "--example"
    assert_predicate testpath/"gajevids_example.yml", :exist?
  end
end 