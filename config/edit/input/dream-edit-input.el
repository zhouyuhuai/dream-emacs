;;; dream-edit-input.el --- Load emacs input configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code

(leaf pyim
  :doc "Emacs input method"
  :url https://github.com/tumashu/pyim
  :straight t
  :require (pyim pyim-cregexp-utils)
  :init
  (leaf pyim-basedict
    :doc "Pinyin grammar library"
    :url https://github.com/tumashu/pyim-basedict
    :straight t
    :init
    (pyim-basedict-enable))
  (setq default-input-method "pyim")
  (setq pyim-page-length 5)
  (setq-default pyim-english-input-switch-functions '(meow-normal-mode-p meow-insert-mode-p)))

(provide 'dream-edit-input)
;;; dream-edit-input.el ends here.
