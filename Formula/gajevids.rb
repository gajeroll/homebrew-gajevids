class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/homebrew-gajevids"
  url "https://github.com/gajeroll/homebrew-gajevids/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "89349bb626d35a3bba961d55af4a0d09a5fe109baab9d05cd29aa67cbca18855"
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
    assert_match "gajevids v0.1.4", shell_output("#{bin}/gajevids --version")
    
    # Test help output
    assert_match "YAML-based FFmpeg video composition tool", shell_output("#{bin}/gajevids --help")
    
    # Test example file creation
    system "#{bin}/gajevids", "--example"
    assert_predicate testpath/"gajevids_example.yml", :exist?
  end
end 