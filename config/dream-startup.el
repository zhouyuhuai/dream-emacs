;;; dream-startup.el --- Start up -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(require 'cl-lib)
(setq-default lexical-binding t)

(when (< emacs-major-version 28)
  (error "This requires Emacs 28.1 and above!"))

(defun add-subdirs-to-load-path (dir)
  "Recursive add directories in DIR to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(defun emacs-base-path (path &optional base)
  "Return absolute PATH BASE 'user-emacs-directory."
  (expand-file-name path (or base user-emacs-directory)))

;; add config subdirs to load path(~/.emacs.d/config/folders)
(defconst *dream-config-path* (emacs-base-path "config"))
(add-subdirs-to-load-path *dream-config-path*)

;; Initialize straight.el
(cl-eval-when (compile eval load)
  (with-no-warnings
    (customize-set-variable 'straight-vc-git-default-clone-depth 1)
    (customize-set-variable 'straight-repository-branch "develop")
    (customize-set-variable 'straight-enable-use-package-integration nil)
    (customize-set-variable 'straight-check-for-modifications nil)))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(eval-when-compile
  (straight-use-package 'leaf)
  (straight-use-package 'leaf-keywords)
  (require 'leaf)
  (require 'leaf-keywords)
  (leaf-keywords-init))

(leaf blackout
  :straight t)

(provide 'dream-startup)
;;; dream-startup.el ends here.
