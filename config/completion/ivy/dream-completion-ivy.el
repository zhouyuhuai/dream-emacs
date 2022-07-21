;;; dream-completion-ivy.el --- Load ivy configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

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
