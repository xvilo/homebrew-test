class Tipctl < Formula
  desc "Command-line interface for the TransIP API"
  homepage "https://www.transip.eu/"
  url "https://github.com/transip/tipctl/releases/download/v6.16.1/tipctl.phar"
  sha256 "36320dbd358a735b488d4ddfe929ab8f890286b36cf72d4729f17e1bc7d6b4a3"
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
