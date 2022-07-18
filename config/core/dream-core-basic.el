;;; dream-core-basic.el --- Core module basic configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

;; Default Settings.
(setq debug-on-error                           t
      gc-cons-threshold                        most-positive-fixnum
      gc-cons-percentage                       0.5
      inhibit-compacting-font-caches           t
      inhibit-startup-message                  t
      inhibit-startup-screen                   t
      inhibit-startup-buffer-menu              t
      initial-major-mode                       'fundamental-mode
      load-prefer-newer                        t
      native-comp-async-jobs-number            4
      ffap-machine-p-known                     'reject
      native-comp-async-report-warnings-errors 'silent
      create-lockfiles                         nil
      make-backup-files                        nil
      auto-save-default                        nil
      blink-cursor-mode                        nil
      ring-bell-function                       'ignore
      use-short-answers                        t)
(setq initial-scratch-message
      (concat ";; Happy hacking, " user-login-name ".\n\n"))

;; Encoding
;; UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))

;; Explicitly set the prefered coding systems to avoid annoying prompt
;; from emacs (especially on Microsoft Windows)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 0.1))
  :global-minor-mode global-auto-revert-mode)

(leaf gcmh
  :doc "The gc management"
  :blackout ""
  :init
  (setq gcmh-idle-delay 10
	gcmh-high-cons-threshold #x6400000) ;; 100MB
  :hook (after-init-hook . gcmh-mode)
  :straight t)

(leaf no-littering
  :straight t
  :require t)

(leaf time
  :init (setq display-time-24hr-format  t
	          display-time-day-and-date t))

(provide 'dream-core-basic)
;;; dream-core-basic.el ends here.
