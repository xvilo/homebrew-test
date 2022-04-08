class Tipctl < Formula
  desc "Command-line interface for the TransIP API"
  homepage "https://www.transip.eu/"
  url "https://github.com/transip/tipctl/releases/download/v6.14.0/tipctl.phar"
  sha256 "567d46eca59860bd30e2da1daa53c81e43f2f02f276a7079d1aac2d5961364ca"
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
