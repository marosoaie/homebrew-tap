# marosoaie/homebrew-tap

Homebrew formulas for [marosoaie](https://github.com/marosoaie) tools.

Both this tap and the source repositories are private: `brew` authenticates
through git, so any machine whose git credentials can reach the repos (e.g.
the macOS keychain helper) can install from here without extra setup.

## git-diff-parser

Show only the build/lint diagnostics a pull request touches
([repo](https://github.com/marosoaie/git-diff-parser)). Builds from source;
requires Xcode 26+.

```sh
brew tap marosoaie/tap
brew install --HEAD marosoaie/tap/git-diff-parser
```

`--HEAD` (build from `main`) is required until the first tagged release.
Once `v1.0.0` ships, add a stable `url ... tag:` stanza to the formula (see
the comment in it) and plain `brew install` will work, pinned to the tag.
