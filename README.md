# marosoaie/homebrew-tap

Homebrew formulas for [marosoaie](https://github.com/marosoaie) tools.

This tap and the source repositories it builds from are public; `brew`
clones them over HTTPS, so no credentials are needed.

## steward

Show only the build/lint diagnostics a pull request touches
([repo](https://github.com/marosoaie/swift-steward)). Builds from source;
requires Xcode 26+.

```sh
brew tap marosoaie/tap
brew trust marosoaie/tap   # one-time; Homebrew 6 gates third-party taps
brew install marosoaie/tap/steward
```

Up to v1.0.2 the formula and its binary were called `git-diff-parser`.
`formula_renames.json` maps the old name to the new one, so `brew upgrade`
moves an existing install over to `steward`.

Installs are pinned to the tagged release in the formula; `--HEAD` builds
from `main` instead. On new releases, bump the formula's `tag:` and
`revision:` to match.
