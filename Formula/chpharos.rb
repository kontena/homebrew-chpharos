class Chpharos < Formula
  desc "Kontena Pharos tool chain version installer and switcher"
  homepage "https://github.com/kontena/chpharos#readme"
  url "https://github.com/kontena/chpharos/archive/v0.5.1.tar.gz"
  sha256 "ef7843958d0f0f466cb1aea67e6c3d344fe720f77b3630c4166924a3f442c33c"
  head "https://github.com/kontena/chpharos.git"

  def install
    system "make", "install", "PREFIX=#{prefix}"
    bash_completion.install "opt/bash-completion.sh" => "chpharos-completion.bash"
    zsh_completion.install_symlink bash_completion/"chpharos-completion.bash" => "_chpharos"
  end

  def caveats; <<~EOS
    Add the following to the ~/.bash_profile or ~/.zshrc file:
      source #{opt_pkgshare}/chpharos.sh

    To enable auto-switching of Pharos versions specified by .pharos-version files,
    add the following to ~/.bash_profile or ~/.zshrc:
      chpharos auto
  EOS
  end

  test do
    assert_equal "chpharos-exec #{version}", shell_output("#{bin}/chpharos-exec --version").strip
  end
end
