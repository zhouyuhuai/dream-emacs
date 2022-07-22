;;; dream-completion-ivy.el --- Load ivy configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

;;; Module Custom

(defcustom +dream-completion-ivy-prescient nil
  "When non-nil, use `prescient.el' with `ivy.el'."
  :type 'boolean)

(defcustom +dream-completion-ivy-fuzzy nil
  "When non-nil, enable fuzzy searches."
  :type 'boolean)


;;; Package

(leaf ivy-prescient
  :doc "simple but effective sorting and filtering for Emacs."
  :url "https://github.com/radian-software/prescient.el"
  :if +dream-completion-ivy-prescient
  :straight t
  :hook
  (ivy-mode . ivy-prescient-mode)
  (ivy-prescient-mode . prescient-persist-mode)
  :require prescient
  :commands +ivy-prescient-non-fuzzy
  :init
  (setq prescient-filter-method
	(if +dream-completion-ivy-fuzzy
	    '(literal regexp initialism fuzzy)
	  '(literal regexp initialism)))
  :config
  ;; REVIEW Remove when radian-software/prescient.el#102 is resolved
  (add-to-list 'ivy-sort-functions-alist '(ivy-resume))
  (setq ivy-prescient-sort-commands
        '(:not swiper swiper-isearch ivy-switch-buffer lsp-ivy-workspace-symbol
          ivy-resume ivy--restore-session counsel-grep counsel-git-grep
          counsel-rg counsel-ag counsel-ack counsel-fzf counsel-pt counsel-imenu
          counsel-yank-pop counsel-recentf counsel-buffer-or-recentf
          counsel-outline counsel-org-goto counsel-jq)
        ivy-prescient-retain-classic-highlighting t)
  (defun +ivy-prescient-non-fuzzy (str)
    (let ((prescient-filter-method '(literal regexp)))
      (ivy-prescient-re-builder str))))

(leaf ivy
  :doc "Completion framework"
  :url "https://github.com/abo-abo/swiper"
  :straight t
  :hook after-init-hook
  :bind
  (("C-s" . 'swiper-isearch)
   ("C-r" . 'swiper-isearch-backward)
   ("C-S-s" . 'swiper-all)
   ([remap switch-to-buffer] . #'+ivy/switch-buffer)
   ([remap switch-to-buffer-other-window] . #'+ivy-switch-buffer-other-window))
  :init
  (let ((standard-search-fn
	 (if +dream-completion-ivy-prescient
	     #'+ivy-prescient-non-fuzzy
	   #'ivy--regex-fuzzy))
	(alt-search-fn
	 (if +dream-completion-ivy-fuzzy
	     #'ivy--regex-fuzzy
	   ;; Ignore order for non-fuzzy searches by default
	   #'ivy--regex-ignore-order)))
    (setq ivy-re-builders-alist
	  `((counsel-rg         . ,standard-search-fn)
	    (swiper             . ,standard-search-fn)
	    (swiper-isearch     . ,standard-search-fn)
	    (t                  . ,alt-search-fn))
	  ivy-more-chars-alist
	  '((counsel-rg     . 1)
	    (counsel-search . 2)
	    (t              . 3))))
  :config
  (setq ivy-height 17
	ivy-wrap t
	ivy-fixed-height-minibuffer t))

(leaf counsel
  :doc "a collection of Ivy-enhanced versions of common Emacs commands."
  :url "https://github.com/abo-abo/swiper"
  :straight t
  :bind
  (([remap execute-extended-command] . 'counsel-M-x)
   ([remap apropos] . 'counsel-apropos)
   ([remap describe-bindings] . 'counsel-descbinds)
   ([remap imenu]   . 'counsel-imenu)
   ([remap find-file] . 'counsel-find-file)
   ([remap yank-pop] . 'counsel-yank-pop))
  (counsel-mode-map
   ([remap swiper] . 'counsel-grep-or-swiper)
   ([remap swiper-backward] . 'counsel-grep-or-swiper-backward)))

(leaf ivy-rich
  :doc "More friendly interface for ivy"
  :url "https://github.com/Yevgnen/ivy-rich"
  :straight t
  :after (ivy counsel)
  :require t
  :config
  (ivy-rich-mode))


(provide 'dream-completion-ivy)
;;; dream-completion-ivy.el ends here.
