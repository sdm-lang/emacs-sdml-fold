# SDML mode code-folding for Emacs

![SDML Logo Text](https://raw.githubusercontent.com/sdm-lang/.github/main/profile/horizontal-text.svg)

This package provides code-folding features for SDML - the
[Simple Domain Modeling Language](https://github.com/johnstonskj/tree-sitter-sdml) buffers.

## Installing

Install the `ts-fold` library (See <https://github.com/emacs-tree-sitter/ts-fold>)
first which is a manual process unfortunately.

Install is easiest from MELPA, here's how with `use-package`. Note the hook clause
to ensure this minor mode is always enabled for SDML source files.

```elisp
(use-package ts-fold
  :load-path "path/to/install")

(use-package sdml-fold
  :after (ts-fold sdml-mode)
  :hook (sdml-mode . sdml-fold-mode)
```

Or, interactively; `M-x package-install RET sdml-ispell RET`

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

## License(s)

The contents of this repository are made available under the following
licenses:

### Apache-2.0

> ```text
> Copyright 2025 Simon Johnston <johnstonskj@gmail.com>
> 
> Licensed under the Apache License, Version 2.0 (the "License");
> you may not use this file except in compliance with the License.
> You may obtain a copy of the License at
> 
>     http://www.apache.org/licenses/LICENSE-2.0
> 
> Unless required by applicable law or agreed to in writing, software
> distributed under the License is distributed on an "AS IS" BASIS,
> WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> See the License for the specific language governing permissions and
> limitations under the License.
> ```

See the enclosed file [LICENSE-Apache](https://github.com/sdm-lang/emacs-sdml-fold/blob/main/LICENSE-APACHE).

### MIT

> ```text
> Copyright 2025 Simon Johnston <johnstonskj@gmail.com>
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the “Software”), to deal
> in the Software without restriction, including without limitation the rights to
> use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
> the Software, and to permit persons to whom the Software is furnished to do so,
> subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
> INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
> PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
> OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
> SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> ```

See the enclosed file [LICENSE-MIT](https://github.com/sdm-lang/emacs-sdml-fold/blob/main/LICENSE-MIT).

### Contributions

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.

## Changes

The `0.1.x` series are all pre-release and do not appear in ELPA/MELPA.
