class Orb < Formula
  desc "OrbLang CLI and MuJoCo XML seam (GLB, STEP and Minecraft not included)"
  homepage "https://github.com/couplet-physical-ai/orb"
  url "https://github.com/couplet-physical-ai/orb/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "4529f27a2b31ed6518be0eca16572e017679a7d182c5e3c67103b3268aa691db"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    libexec.install "orb"
    libexec.install "LICENSE", "NOTICE"
    (bin/"orb").write <<~SH
      #!/bin/sh
      export PYTHONPATH="#{libexec}${PYTHONPATH:+:$PYTHONPATH}"
      exec "#{Formula["python@3.12"].opt_bin}/python3.12" -m orb.cli "$@"
    SH
  end

  test do
    project = testpath/"project"
    project.mkpath
    (project/"main.orb").write('part "crate" { mass = 1 kg }')
    assert_match "valid OrbLang project", shell_output("#{bin}/orb validate #{project}")
  end
end
