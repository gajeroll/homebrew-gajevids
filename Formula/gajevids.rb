class Gajevids < Formula
  desc "YAML-based FFmpeg video composition tool"
  homepage "https://github.com/gajeroll/gajevids"
  url "https://github.com/gajeroll/gajevids/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"
  head "https://github.com/gajeroll/gajevids.git", branch: "main"

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
    assert_match "gajevids v0.1.0", shell_output("#{bin}/gajevids --version")
    
    # Test help output
    assert_match "YAML-based FFmpeg video composition tool", shell_output("#{bin}/gajevids --help")
    
    # Test example file creation
    system "#{bin}/gajevids", "--example"
    assert_predicate testpath/"gajevids_example.yml", :exist?
  end
end 