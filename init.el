;;; init.el --- Ben Chen's Emacs Configuration -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Ben Chen
;; Author: Ben Chen <517926804@qq.com>
;; Homepage: https://github.com/bbenchen/.emacs.d
;;
;;  ___     c  c  wWw \\\    ///          c  c  oo_
;; (___)__  (OO)  (O)_((O)  (O))   /)     (OO) /  _)-<
;; (O)(O) ,'.--.) / __)| \  / |  (o)(O) ,'.--.)\__ `.
;; /  _\ / //_|_\/ (   ||\\//||   //\\ / //_|_\   `. |
;; | |_))| \___ (  _)  || \/ ||  |(__)|| \___     _| |
;; | |_))'.    ) \ \_  ||    ||  /,-. |'.    ) ,-'   |
;; (.'-'   `-.'   \__)(_/    \_)-'   ''  `-.' (_..--'
;;
;;; Commentary:
;;
;; Ben Chen's Emacs Configuration
;;
;;; Code:

(let ((minver "29"))
  (when (version< emacs-version minver)
    (warn "This configuration depends on Emacs %s or higher" minver)))

;; Load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
  (normal-top-level-add-subdirs-to-load-path))

;; Bootstrap Configuration

(require 'init-benchmark)
(require 'init-constant)
(require 'init-custom)
(require 'init-package)
(require 'init-tweaks)
(require 'init-ui)
(require 'init-editor)
(require 'init-which-key)
(require 'init-completion)
(require 'init-yasnippet)
;; (require 'init-corfu)
(require 'init-lsp-bridge)
(require 'init-ibuffer)
(require 'init-server)

;;; init.el ends here
