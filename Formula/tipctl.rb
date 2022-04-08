class Tipctl < Formula
  desc "Command-line interface for the TransIP API"
  homepage "https://www.transip.eu/"
  url "https://github.com/transip/tipctl/releases/download/v6.16.1/tipctl.phar"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "Apache-2.0"

  depends_on "php"

  def install
    libexec.install "tipctl.phar"

    (bin/"tipctl").write <<~EOS
      #!#{Formula["php"].opt_bin}/php
      <?php require '#{libexec}/tipctl.phar';
    EOS
  end

  test do
    assert_match(/^Transip RestAPI CLI ([0-9]\d*.[0-9]\d*.[0-9]\d*)/,
          shell_output("#{bin}/tipctl"))
  end
end
