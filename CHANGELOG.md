# Change Log
All notable changes to this project will be documented in this file. See [Keep
a CHANGELOG](http://keepachangelog.com/).

## [Unreleased][unreleased]
- Fork from [`smallcheck-lens`](https://github.com/jdnavarro/smallcheck-lens).

## [0.3] - 2015-09-11
### Changed
- More sensible function names assuming qualified imports.
- Pass functor to use in `Traversal` as a `Proxy` instead of hardcoding
  the functors.
- Rank-2 `Lens-Like` everywhere.

### Added
- *Exhaustive* property testing using `Series` product. Previous
  properties renamed appending `Sum`.

### Removed
- Main re-export module.
- Move `Tasty` modules to a separate package
  [`tasty-lens`](https://hackage.haskell.org/package/tasty-lens).
- `pureMaybe`. Now a `Proxy functor` is used.

## [0.1] - 2015-05-27
### Added
- `SmallCheck` properties for each lens laws.
- `tasty` test trees for each `Lens` type.
- Tests for some `Lens`.

[unreleased]: https://github.com/jdnavarro/lens-laws/compare/v0.3...HEAD
[0.3]: https://github.com/jdnavarro/lens-laws/compare/v0.1...v0.3
[0.1]: https://github.com/jdnavarro/lens-laws/compare/1df060...v0.1
