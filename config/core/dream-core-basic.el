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

(provide 'dream-core-basic)
;;; dream-core-basic.el ends here.
