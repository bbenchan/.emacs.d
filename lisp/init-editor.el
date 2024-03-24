;;; init-editor.el --- Initialize editor configuration.  -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mike Chen
;;
;; Author: Mike Chen <xianbin.chen@fa-software.com>
;; Maintainer: Mike Chen <xianbin.chen@fa-software.com>
;; Created: November 29, 2023
;; Modified: November 29, 2023
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/bbenchen/init-editor
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Initialize editor configuration.
;;
;;; Code:

;; Automatic parenthesis pairing
(use-package elec-pair
  :hook (after-init . electric-pair-mode)
  :init (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit))

;; Delete selection if you insert
(use-package delsel
  :hook (after-init . delete-selection-mode))

;; Automatically reload files was modified by external program
(use-package autorevert
  :diminish
  :hook (after-init . global-auto-revert-mode))

;; Hungry deletion
(use-package hungry-delete
  :diminish
  :hook (after-init . global-hungry-delete-mode)
  :init (setq hungry-delete-chars-to-skip " \t\f\v"
              hungry-delete-except-modes
              '(help-mode minibuffer-mode minibuffer-inactive-mode calc-mode)))

;; Increase selected region by semantic units
(use-package expand-region
  :bind ("C-=" . er/expand-region)
  :config
  (defun treesit-mark-bigger-node ()
      "Use tree-sitter to mark regions."
      (let* ((root (treesit-buffer-root-node))
             (node (treesit-node-descendant-for-range root (region-beginning) (region-end)))
             (node-start (treesit-node-start node))
             (node-end (treesit-node-end node)))
        ;; Node fits the region exactly. Try its parent node instead.
        (when (and (= (region-beginning) node-start) (= (region-end) node-end))
          (when-let ((node (treesit-node-parent node)))
            (setq node-start (treesit-node-start node)
                  node-end (treesit-node-end node))))
        (set-mark node-end)
        (goto-char node-start)))
  (add-to-list 'er/try-expand-list 'treesit-mark-bigger-node))


(provide 'init-editor)
;;; init-editor.el ends here
