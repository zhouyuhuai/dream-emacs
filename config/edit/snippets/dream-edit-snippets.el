;;; dream-edit-snippets.el --- Load snippets configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf yasnippet
  :blackout yas-minor-mode
  :doc "snippets"
  :url "https://github.com/joaotavora/yasnippet"
  :straight t
  :hook (after-init-hook . yas-global-mode)
  :pre-setq
  ;; Remove default ~/.emacs.d/snippets
  (yas-snippet-dirs . nil))

(provide 'dream-edit-snippets)
;;; dream-edit-snippets.el ends here.
