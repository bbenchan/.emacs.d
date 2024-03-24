;;; init-which-key.el --- Which-Key Configuration -*- lexical-binding: t; -*-
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
;; Which Key Configuration
;;
;;; Code:

(use-package which-key
  :hook (after-init . which-key-mode)
  :init (setq which-key-sort-order #'which-key-key-order-alpha
              which-key-sort-uppercase-first nil
              which-key-add-column-padding 1
              which-key-max-display-columns nil
              which-key-max-description-length 30
              which-key-min-display-lines 6
              which-key-side-window-slot -10)
  :config
  (which-key-setup-side-window-bottom)

  (add-hook 'which-key-init-buffer-hook #'(lambda ()
                                            (setq-local line-spacing 3))))

(provide 'init-which-key)
;;; init-which-key.el ends here
