;;; early-init.el --- Emacs 27+ pre-initialisation config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Do not initialise the package manager. 
(setq package-enable-at-startup nil)

;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist))

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

(defun font-installed-p (font)
  "Check if the FONT is available."
  (find-font (font-spec :name font)))

(provide 'early-init)
;;; early-init.el ends here.
