;;; dream-core.el --- Load core module configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf dream-core-basic
  :doc "Load core module basic configuration"
  :require t)

(leaf dream-core-which-key
  :doc "Load which-key configuratio"
  :require t)

(leaf company
  :blackout ""
  :hook after-init-hook
  :straight t
  :config
  (global-company-mode 1))

(provide 'dream-core)
;;; dream-core.el ends here.
