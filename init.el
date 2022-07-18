;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code

;; Start up
(load-file (expand-file-name "config/dream-startup.el" user-emacs-directory))

;; Load core module
(leaf dream-core :require t)

;; Load edit module
(leaf dream-edit :require t)
