;;; init-benchmark.el --- Benchmark Configuration -*- lexical-binding: t; -*-
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
;; Benchmark Configuration
;;
;;; Code:

(defun bc/show-init-time()
  "Display initial completion time."
  (message "Initialization is done in %.03fs"
           (float-time (time-subtract (current-time) before-init-time))))

(add-hook 'after-init-hook #'bc/show-init-time)

(provide 'init-benchmark)
;;; init-benchmark.el ends here
