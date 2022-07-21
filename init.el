;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code

;; Start up
(load-file (expand-file-name "config/dream-startup.el" user-emacs-directory))

(leaf dream-core
  :doc "Load core module"
  :require t)

(leaf dream-completion
  :doc "Load completion module"
  :require t)

(leaf dream-edit
  :doc "Load edit module"
  :require t)

(leaf dream-ui
  :doc "Load ui module"
  :require t)

(leaf dream-program
  :doc "Load program module"
  :require t)
