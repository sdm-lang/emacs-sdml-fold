# SDML mode code-folding for Emacs

![SDML Logo Text](https://raw.githubusercontent.com/sdm-lang/.github/main/profile/horizontal-text.svg)

This package provides an Emacs tree-sitter based minor mode for SDML - the
[Simple Domain Modeling Language](https://github.com/johnstonskj/tree-sitter-sdml). This mode provides code-folding features for
the `sdml-mode` package.

## Installing

Currently the package is not published and so installation has to be done
manually. You will also need to install the base `sdml-mode` first.

### Install manually

First clone the Git repository to a local path.

```bash
    git clone https://github.com/johnstonskj/emacs-sdml-fold.git
```

The following uses `use-package` but any equivalent package manager should work.

```elisp
(use-package sdml-fold
  :after sdml-mode
  :load-path "/path/to/repo")
```

### Usage

Block Folding is provided by the `ts-fold-mode` minor mode based on the
configuration in the constant `sdml-mode-tree-sitter-indent-scopes`. Note that
folding of groups of line comments is also supported.

* `C-c C-s -` -- fold item
* `C-c C-s +` -- unfold item
* `C-c C-s C--` -- fold all items in buffer
* `C-c C-s C-+` -- unfold all items in buffer
* `C-c C-s /` -- unfold item and all children
* `C-c C-s .` -- toggle fold/unfold state

As well as the mechanics of folding, the `ts-fold` package also has a fringe
indicator support for windowed clients and this is enabled by default with
`window-system` is non-`nil`.

To switch to left/right fringe (default is left-fringe):

```elisp
(setq ts-fold-indicators-fringe 'right-fringe)
```
To lower/higher the fringe overlay's priority (default is 30):

```elisp
(setq ts-fold-indicators-priority 30)
```

These options can be included in the `use-package` macro as shown below.

```elisp
(use-package sdml-fold
  :after sdml-mode
  :custom
  (ts-fold-indicators-fringe 'right-fringe)
  (ts-fold-indicators-priority 30)
  :load-path "/path/to/repo")
```

## Contributing

The packages in this repository should pass the standard package checks,
including:

* `byte-compile-file`
* `package-lint`
* `checkdoc`

## License

This package is released under the Apache License, Version 2.0. See the LICENSE
file in this repository for details.

## Changes

The `0.1.x` series are all pre-release and do not appear in ELPA/MELPA.
