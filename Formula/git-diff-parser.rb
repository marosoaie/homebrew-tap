class GitDiffParser < Formula
  desc "Show only the build/lint diagnostics a pull request touches"
  homepage "https://github.com/marosoaie/git-diff-parser"
  url "https://github.com/marosoaie/git-diff-parser.git",
      tag:      "v1.0.1",
      revision: "22e54dbbb7e05b589dd8af4e14f646aa731239ca"
  license "MIT"
  head "https://github.com/marosoaie/git-diff-parser.git", branch: "main"

  depends_on xcode: ["26.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/git-diff-parser"
  end

  test do
    (testpath/"pr.diff").write <<~DIFF
      diff --git a/f.txt b/f.txt
      --- a/f.txt
      +++ b/f.txt
      @@ -1 +1,2 @@
       x
      +y
    DIFF
    assert_match "f.txt:2", shell_output("#{bin}/git-diff-parser changes #{testpath}/pr.diff --format text")
    (testpath/"build.log").write "/repo/f.txt:2:1: warning: on a changed line"
    output = shell_output(
      "#{bin}/git-diff-parser filter #{testpath}/build.log --diff #{testpath}/pr.diff --format text",
    )
    assert_match "on a changed line", output
  end
end
