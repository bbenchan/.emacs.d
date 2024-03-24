;;; init-yasnippet.el --- Initialize yasnippet configuration. -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mike Chen
;;
;; Author: Mike Chen <xianbin.chen@fa-software.com>
;; Maintainer: Mike Chen <xianbin.chen@fa-software.com>
;; Created: November 29, 2023
;; Modified: November 29, 2023
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/bbenchen/init-yasnippet
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Initialize yasnippet configuration.
;;
;;; Code:

;; Yet another snippet extension
(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode))

(use-package consult-yasnippet
  :bind ("M-g y" . consult-yasnippet))

;; Collection of yasnippet snippets
(use-package yasnippet-snippets
  :after yasnippet)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
