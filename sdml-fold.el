;;; sdml-fold.el --- Code folding for SDML -*- lexical-binding: t; -*-

;; Author: Simon Johnston <johnstonskj@gmail.com>
;; Version: 0.1.5
;; Package-Requires: ((emacs "28.2") (sdml-mode "0.1.8"))
;; URL: https://github.com/johnstonskj/emacs-sdml-mode
;; Keywords: languages tools

;;; License:

;; Copyright (c) 2023, 2024 Simon Johnston
;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;     http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.

;;; Commentary:

;; This package provides a tree-sitter based fold mode for SDML.
;;

;; Installation
;;
;; Install the `ts-fold' library first which is a manual process unfortunately.
;;
;; See https://github.com/emacs-tree-sitter/ts-fold
;;
;; `(require 'sdml-mode)'
;; `(require 'ts-fold)'
;; `(require 'sdml-fold)'
;;

;; Folding
;;
;; This uses a package `ts-fold' which is not provided by any repository and must
;; therefore be installed and required PRIOR to this package if you want to enable
;; folding.
;;
;; `\\[ts-fold-close]' -- fold item
;; `\\[ts-fold-open]' -- unfold item
;; `\\[ts-fold-close-all]' -- fold all items in buffer
;; `\\[ts-fold-open-all]' -- unfold all items in buffer
;; `\\[ts-fold-open-recursively]' -- unfold item and all children
;; `\\[ts-fold-toggle]' -- toggle fold/unfold state
;;

;; Fold Indicators
;;
;; This is only enabled if folding is enabled (see above) and running in GUI mode.
;; To enable, put `(require 'ts-fold-indicators)' before requiring `sdml-fold'.
;;
;; To switch to left/right fringe: (Default is left-fringe)
;;
;; `(setq ts-fold-indicators-fringe 'right-fringe)'
;;
;; To lower/higher the fringe overlay's priority: (Default is 30)
;;
;; `(setq ts-fold-indicators-priority 30)'
;;

;;; Code:

(require 'sdml-mode)

(declare-function ts-fold-mode "ts-fold" ())
(declare-function ts-fold-line-comment-mode "ts-fold" ())
(declare-function ts-fold-indicators-mode "ts-fold-indicators" (toggle))

(defvar ts-fold-range-alist)

(when (featurep 'ts-fold)
  ;; The package `ts-fold' must be installed and required PRIOR to this
  ;; package if you want to enable folding.

  (defconst sdml-fold-definitions
    '(;; definitions
      (data_type_def . (ts-fold-range-seq 7 2))
      (entity_def . (ts-fold-range-seq 5 2))
      (enum_def . (ts-fold-range-seq 3 2))
      (event_def . (ts-fold-range-seq 4 2))
      (property_def . (ts-fold-range-seq 7 2))
      (structure_def . (ts-fold-range-seq 8 2))
      (type_class_def . (ts-fold-range-seq 4 2))
      (union_def . (ts-fold-range-seq 4 2))
      (rdf_thing_def . (ts-fold-range-seq 2 2))
      ;; bodies
      (annotation_only_body . (ts-fold-range-seq 1 -2))
      (entity_body . (ts-fold-range-seq 1 -2))
      (enum_body . (ts-fold-range-seq 1 -2))
      (property_body . (ts-fold-range-seq 1 -2))
      (structure_body . (ts-fold-range-seq 1 -2))
      (type_class_body . (ts-fold-range-seq 1 -2))
      (union_body . (ts-fold-range-seq 1 -2))
      ;; Constraints
      (constraint . (ts-fold-range-seq 5 2))
      (sequence_builder . ts-fold-range-seq)
      ;; values
      (sequence_of_values . ts-fold-range-seq)
      (sequence_of_predicate_values . ts-fold-range-seq)
      ;; comments
      (line_comment . (lambda (node offset) (ts-fold-range-line-comment node offset ";;")))))

  (define-key sdml-mode-map (kbd "C-c C-s -") 'ts-fold-close)
  (define-key sdml-mode-map (kbd "C-c C-s +") 'ts-fold-open)
  (define-key sdml-mode-map (kbd "C-c C-s C--") 'ts-fold-close-all)
  (define-key sdml-mode-map (kbd "C-c C-s C-+") 'ts-fold-open-all)
  (define-key sdml-mode-map (kbd "C-c C-s /") 'ts-fold-open-recursively)
  (define-key sdml-mode-map (kbd "C-c C-s .") 'ts-fold-toggle)

  (add-to-list 'ts-fold-range-alist
               `(sdml-mode . ,sdml-fold-definitions)))

;; --------------------------------------------------------------------------
;; Folding Minor Mode
;; --------------------------------------------------------------------------

;;;###autoload
(define-minor-mode sdml-fold-mode
  "Add code folding to the `sdml-mode' major mode."
  :group 'sdml
  :tag "Enable SDML code folding minor mode"
  :lighter nil
  (cond
   ((featurep 'ts-fold)
    (ts-fold-mode)
    (ts-fold-line-comment-mode)
    (when (and window-system (functionp 'ts-fold-indicators-mode))
      (ts-fold-indicators-mode 1)))
   (t
    (message "Warning: sdml-fold-setup not enabled, no ts-fold"))))

;;;###autoload
(add-hook 'sdml-mode-hook 'sdml-fold-mode)

(provide 'sdml-fold)

;;; sdml-fold.el ends here
