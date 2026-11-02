class Steward < Formula
  desc "Show only the build/lint diagnostics a pull request touches"
  homepage "https://github.com/marosoaie/swift-steward"
  url "https://github.com/marosoaie/swift-steward.git",
      tag:      "v0.1.0",
      revision: "1fc1e25c9008aab57a186401bec248af04ee03d6"
  license "MIT"
  head "https://github.com/marosoaie/swift-steward.git", branch: "main"

  depends_on xcode: ["26.0", :build]

  on_macos do
    depends_on macos: :tahoe
  end

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
