;;; dream-core-which-key.el --- Load which-key configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf which-key
  :blackout ""
  :doc "Command prompt"
  :url https://github.com/justbur/emacs-which-key
  :straight t
  :hook (after-init-hook . which-key-mode)
  :init
  (setq which-key-sort-uppercase-first nil
	which-key-max-display-columns  nil
	which-key-min-display-lines    6)
  :config
  (which-key-setup-side-window-bottom))

(provide 'dream-core-which-key)
;;; dream-core-which-key.el ends here.
