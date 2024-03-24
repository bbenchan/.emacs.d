;;; init-corfu.el --- Initialize corfu configuration. -*- lexical-binding: t; -*-
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
;;  Initialize corfu configuration.
;;
;;; Code:

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-preview-current nil)
  (corfu-auto-delay 0.1)
  (corfu-popupinfo-delay '(0.2 . 0.1))
  :custom-face
  (corfu-border ((t (:inherit region :background unspecified))))
  :bind ("M-/" . completion-at-point)
  :hook ((after-init . global-corfu-mode)
         (global-corfu-mode . corfu-popupinfo-mode)))

(use-package nerd-icons-corfu
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Add extensions
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-abbrev))

(provide 'init-corfu)
;;; init-corfu.el ends here
