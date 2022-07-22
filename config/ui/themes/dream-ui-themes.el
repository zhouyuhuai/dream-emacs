;;; dream-ui-themes.el --- Load themes configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf vscode-dark-plus-theme
  :doc "themes"
  :url "https://github.com/ianyepan/vscode-dark-plus-emacs-theme"
  :straight t
  :config
  (load-theme 'vscode-dark-plus t))

(leaf solaire-mode
  :url https://github.com/hlissner/emacs-solaire-mode
  :straight t
  :config
  (solaire-global-mode 1))

(provide 'dream-ui-themes)
;;; dream-ui-themes.el ends here.
