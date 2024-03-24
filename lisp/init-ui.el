;;; init-ui.el --- UI Configuration -*- lexical-binding: t; -*-
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
;;  UI Configuration
;;
;;; Code:

;; transparency
(set-frame-parameter nil 'alpha 85)
(add-to-list 'default-frame-alist '(alpha . 85))

(use-package solaire-mode
  :hook (after-load-theme . solaire-global-mode))

(use-package doom-themes
  :hook (after-init . (lambda ()
                        (load-theme 'doom-nord-aurora t)))
  :config
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init (setq doom-modeline-icon t
              doom-modeline-minor-modes nil
              doom-modeline-height 25))

(provide 'init-ui)
;;; init-ui.el ends here
