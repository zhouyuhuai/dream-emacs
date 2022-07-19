;;; dream-core.el --- Load core module configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf dream-core-basic :require t)

(leaf company
  :hook after-init-hook
  :straight t
  :config
  (global-company-mode 1))

(provide 'dream-core)
;;; dream-core.el ends here.
