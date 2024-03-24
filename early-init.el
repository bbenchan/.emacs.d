;;; early-init.el --- Early initialization -*- lexical-binding: t; -*-
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
;; early-init.el was introduced in Emacs 27.1. It is loaded before init.el,
;; before Emacs initializes its UI or package.el, and before site files are
;; loaded. This is great place for startup optimizing, because only here can you
;; *prevent* things from loading, rather than turn them off after-the-fact.
;;
;;; Code:

;; PERF: Garbage collection is a big contributor to startup times. This fends it
;;   off, but will be reset later by `gcmh-mode'. Not resetting it later will
;;   cause stuttering/freezes.
(setq gc-cons-threshold most-positive-fixnum)

;; PERF: Don't use precious startup time checking mtime on elisp bytecode.
;;   Ensuring correctness is 'doom sync's job, not the interactive session's.
;;   Still, stale byte-code will cause *heavy* losses in startup efficiency.
(setq load-prefer-newer noninteractive)

;; PERF: Resizing the Emacs frame (to accommodate fonts that are smaller or
;;   larger than the system font) appears to impact startup time
;;   dramatically. The larger the delta in font size, the greater the delay.
;;   Even trivial deltas can yield a ~1000ms loss, though it varies wildly
;;   depending on font size.
(setq frame-inhibit-implied-resize t)

;; PERF,UX: Reduce *Message* noise at startup. An empty scratch buffer (or
;;   the dashboard) is more than enough, and faster to display.
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name)
;; PERF,UX: Remove "For information about GNU Emacs..." message at startup.
;;   It's redundant with our dashboard and incurs a premature redraw.
(advice-add #'display-startup-echo-area-message :override #'ignore)
;; PERF: Suppress the vanilla startup screen completely. We've disabled it
;;   with `inhibit-startup-screen', but it would still initialize anyway.
;;   This involves some file IO and/or bitmap work (depending on the frame
;;   type) that we can no-op for a free 50-100ms boost in startup time.
(advice-add #'display-startup-screen :override #'ignore)

;; PERF: Shave seconds off startup time by starting the scratch buffer in
;;   `fundamental-mode', rather than, say, `org-mode' or `text-mode', which
;;   pull in a ton of packages. `doom/open-scratch-buffer' provides a better
;;   scratch buffer anyway.
(setq initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;; PERF: Unset a non-trivial list of command line options that aren't
;;   relevant to our current OS, but `command-line-1' still processes.
(unless (eq system-type 'darwin)
  (setq command-line-ns-option-alist nil))
(unless (memq initial-window-system '(x pgtk))
  (setq command-line-x-option-alist nil))

;;; Suppress package.el
;; Since Emacs 27, package initialization occurs before `user-init-file' is
;; loaded, but after `early-init-file'. Doom handles package initialization, so
;; we must prevent Emacs from doing it again.
(setq package-enable-at-startup nil)

;;; Reduce unnecessary/unactionable warnings/logs
;; Disable warnings from the legacy advice API. They aren't actionable or
;; useful, and often come from third party packages.
(setq ad-redefinition-action 'accept)

;; Ignore warnings about "existing variables being aliased". Otherwise the user
;; gets very intrusive popup warnings about our (intentional) uses of
;; defvaralias, which are done because ensuring aliases are created before
;; packages are loaded is an unneeded and unhelpful maintenance burden. Emacs
;; still aliases them fine regardless.
(setq warning-suppress-types '((defvaralias)))

;; Disable byte compiler warnings. This is a personal choice and can be removed
;; if you would like to see any and all byte compiler warnings.
(setq byte-compile-warnings nil)

;; Reduce debug output unless we've asked for it.
(setq debug-on-error init-file-debug
      jka-compr-verbose init-file-debug)

;;; Stricter security defaults
;; Emacs is essentially one huge security vulnerability, what with all the
;; dependencies it pulls in from all corners of the globe. Let's try to be a
;; *little* more discerning.
(setq gnutls-verify-error noninteractive
      gnutls-algorithm-priority
      (when (boundp 'libgnutls-version)
        (concat "SECURE128:+SECURE192:-VERS-ALL"
                (if (and (not (memq system-type '(cygwin windows-nt ms-dos)))
                         (>= libgnutls-version 30605))
                    ":+VERS-TLS1.3")
                ":+VERS-TLS1.2"))
      ;; `gnutls-min-prime-bits' is set based on recommendations from
      ;; https://www.keylength.com/en/4/
      gnutls-min-prime-bits 3072
      tls-checktrust gnutls-verify-error
      ;; Emacs is built with gnutls.el by default, so `tls-program' won't
      ;; typically be used, but in the odd case that it does, we ensure a more
      ;; secure default for it (falling back to `openssl' if absolutely
      ;; necessary). See https://redd.it/8sykl1 for details.
      tls-program '("openssl s_client -connect %h:%p -CAfile %t -nbio -no_ssl3 -no_tls1 -no_tls1_1 -ign_eof"
                    "gnutls-cli -p %p --dh-bits=3072 --ocsp --x509cafile=%t \
--strict-tofu --priority='SECURE192:+SECURE128:-VERS-ALL:+VERS-TLS1.2:+VERS-TLS1.3' %h"
                    ;; compatibility fallbacks
                    "gnutls-cli -p %p %h"))

;;
;;; Reasonable defaults for interactive sessions

;;; Runtime optimizations
;; PERF: A second, case-insensitive pass over `auto-mode-alist' is time wasted.
(setq auto-mode-case-fold nil)

;; PERF: Disable bidirectional text scanning for a modest performance boost.
;;   I've set this to `nil' in the past, but the `bidi-display-reordering's docs
;;   say that is an undefined state and suggest this to be just as good:
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

;; PERF: Disabling BPA makes redisplay faster, but might produce incorrect
;;   reordering of bidirectional text with embedded parentheses (and other
;;   bracket characters whose 'paired-bracket' Unicode property is non-nil).
(setq bidi-inhibit-bpa t)  ; Emacs 27+ only

;; Reduce rendering/line scan work for Emacs by not rendering cursors or regions
;; in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; More performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate syntax highlighting right after scrolling, which should
;; quickly self-correct.
(setq fast-but-imprecise-scrolling t)

;; Don't ping things that look like domain names.
(setq ffap-machine-p-known 'reject)

;; Emacs "updates" its ui more often than it needs to, so slow it down slightly
(setq idle-update-delay 1.0)  ; default is 0.5

;; Font compacting can be terribly expensive, especially for rendering icon
;; fonts on Windows. Whether disabling it has a notable affect on Linux and Mac
;; hasn't been determined, but do it anyway, just in case. This increases memory
;; usage, however!
(setq inhibit-compacting-font-caches t)

;; Increase how much is read from processes in a single chunk (default is 4kb).
;; This is further increased elsewhere, where needed (like our LSP module).
(setq read-process-output-max (* 64 1024))  ; 64kb

;; Introduced in Emacs HEAD (b2f8c9f), this inhibits fontification while
;; receiving input, which should help a little with scrolling performance.
(setq redisplay-skip-fontification-on-input t)

;; Performance on Windows is considerably worse than elsewhere. We'll need
;; everything we can get.
(when (eq system-type 'windows-nt)
  (setq w32-get-true-file-attributes nil   ; decrease file IO workload
        w32-use-native-image-API t         ; use native w32 API
        w32-pipe-read-delay 0              ; faster IPC
        w32-pipe-buffer-size (* 64 1024))) ; read more at a time (was 4K)

;;; Encodings
;; Set UTF-8 as the default coding system
(prefer-coding-system 'utf-8)
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(set-default-coding-systems 'utf-8)
(set-language-environment "UTF-8")
(set-locale-environment "en_US.UTF-8")
;; Use UTF-16-LE in Windows, see: rufflewind.com/2014-07-20/pasting-unicode-in-emacs-on-windows
(set-selection-coding-system (if (memq system-type '(cygwin windows-nt ms-dos)) 'utf-16-le 'utf-8))
(setq default-input-method nil)
(setq system-time-locale "C")

;;; Disable UI elements early
(push '(menu-bar-lines . 0)   default-frame-alist)
(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(if (featurep 'ns)
    (push '(ns-transparent-titlebar . t) default-frame-alist))
(setq-default mode-line-format nil)

;;; early-init.el ends here
