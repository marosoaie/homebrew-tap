class Steward < Formula
  desc "Show only the build/lint diagnostics a pull request touches"
  homepage "https://github.com/marosoaie/swift-steward"
  url "https://github.com/marosoaie/swift-steward.git",
      tag:      "v2.0.0",
      revision: "130b762314ebb150fa2cb6614ddfe1a07787f05f"
  license "MIT"
  head "https://github.com/marosoaie/swift-steward.git", branch: "main"

  depends_on xcode: ["26.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/steward"
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
    assert_match "f.txt:2", shell_output("#{bin}/steward changes #{testpath}/pr.diff --format text")
    (testpath/"build.log").write "/repo/f.txt:2:1: warning: on a changed line"
    output = shell_output(
      "#{bin}/steward filter #{testpath}/build.log --diff #{testpath}/pr.diff --format text",
    )
    assert_match "on a changed line", output
  end
end
