;;; dream-completion.el --- Load completion module configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf dream-completion-ivy
  :doc "Load ivy configuration"
  :require t
  :init
  (setq +dream-completion-ivy-prescient t))

(provide 'dream-completion)
;;; dream-completion.el ends here.
