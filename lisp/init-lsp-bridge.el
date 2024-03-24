;;; init-lsp-bridge.el --- Initialize lsp-bridge configuration. -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mike Chen
;;
;; Author: Mike Chen <xianbin.chen@fa-software.com>
;; Maintainer: Mike Chen <xianbin.chen@fa-software.com>
;; Created: November 29, 2023
;; Modified: November 29, 2023
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/bbenchen/init-lsp-bridge
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Initialize lsp-bridge configuration.
;;
;;; Code:

(use-package lsp-bridge
  :straight '(lsp-bridge :type git :host github :repo "bbenchen/lsp-bridge"
            :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
            :build (:not compile))
  :init (global-lsp-bridge-mode))

(provide 'init-lsp-bridge)
;;; init-lsp-bridge.el ends here
