;;; init-custom.el --- Customization Definition -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Ben Chan
;; Author: Ben Chan <517926804@qq.com>
;; Homepage: https://github.com/bbenchan/.emacs.d
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
;;  Customization Definition
;;
;;; Code:

(defcustom bc/http-proxy-host "127.0.0.1"
  "Http/Https proxy host."
  :group 'bcemacs
  :type 'string)

(defcustom bc/http-proxy-port 7890
  "Http/Https proxy port."
  :group 'bcemacs
  :type 'integer)

(defcustom bc/server t
  "Enable `server-mode' or not."
  :group 'bcemacs
  :type 'boolean)

;; Load `custom-file'
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(if (file-readable-p custom-file)
    (load custom-file))

(provide 'init-custom)
;;; init-custom.el ends here
