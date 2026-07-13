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
brew trust marosoaie/tap   # one-time; Homebrew 6 gates third-party taps
brew install marosoaie/tap/git-diff-parser
```

Installs are pinned to the tagged release in the formula; `--HEAD` builds
from `main` instead. On new releases, bump the formula's `tag:` and
`revision:` to match.
