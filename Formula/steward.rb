class Steward < Formula
  desc "Show only the build/lint diagnostics a pull request touches"
  homepage "https://github.com/marosoaie/swift-steward"
  url "https://github.com/marosoaie/swift-steward.git",
      tag:      "v0.1.1",
      revision: "fd3cd9339901380e0077ac166fd568875fb6d79c"
  license "MIT"
  # swift-steward restarted at 0.1.0 after 2.0.0; the scheme lets `brew upgrade` take it.
  version_scheme 1
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
