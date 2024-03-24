;;; init-ui.el --- Initialize IBuffer Configuration -*- lexical-binding: t; -*-
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
;;  Initialize IBuffer Configuration
;;
;;; Code:

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :init (setq ibuffer-filter-group-name-face '(:inherit (font-lock-string-face bold))))

;; Display icons for ibuffer
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode)
  :init (setq nerd-icons-ibuffer-icon t))

;; Group ibuffer's list by project
(use-package ibuffer-project
  :hook (ibuffer . (lambda ()
                     "Group ibuffer's list by project."
                     (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
                     (unless (eq ibuffer-sorting-mode 'project-file-relative)
                       (ibuffer-do-sort-by-project-file-relative))))
  :init (setq ibuffer-project-use-cache t)
  :config
  (defun bc/ibuffer-project-group-name (root type)
    "Return group name for project ROOT and TYPE."
    (if (and (stringp type) (> (length type) 0))
        (format "%s %s" type root)
      (format "%s" root)))
  (advice-add #'ibuffer-project-group-name :override #'bc/ibuffer-project-group-name)
  (setq ibuffer-project-root-functions
        `((ibuffer-project-project-root . ,(nerd-icons-octicon "nf-oct-repo" :height 1.2 :face ibuffer-filter-group-name-face))
          (file-remote-p . ,(nerd-icons-codicon "nf-cod-radio_tower" :height 1.2 :face ibuffer-filter-group-name-face)))))

(provide 'init-ibuffer)
;;; init-ui.el ends here
