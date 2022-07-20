;;; dream-program-syntax-check.el --- Load syntax check configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf flycheck
  :doc "Syntax Check"
  :url https://github.com/flycheck/flycheck
  :straight t
  :hook (after-init-hook . global-flycheck-mode)
  :init
  (setq flycheck-global-modes '(not text-mode outline-mode fundamental-mode lisp-interaction-mode
				    org-mode diff-mode eshell-mode emacs-lisp-mode)
	flycheck-indication-mode (if (display-graphic-p)
				     'right-fringe
				   'right-margin)
	;; Only check while saveing and open files
	flycheck-check-syntax-automatically '(save mode-enanled)))

(provide 'dream-program-syntax-check)
;;; dream-program-syntax-check.el ends here.
