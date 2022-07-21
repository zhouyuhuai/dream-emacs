;;; config/completion/ivy/autoload/ivy.el -*- lexical-binding: t; -*-

;;
;; Library

(defun +ivy--switch-buffer-preview ()
  (let (ivy-use-virtual-buffers ivy--virtual-buffers)
    (counsel--switch-buffer-update-fn)))

(defalias '+ivy--switch-buffer-preview-all #'counsel--switch-buffer-update-fn)
(defalias '+ivy--switch-buffer-unwind      #'counsel--switch-buffer-unwind)

(defun +ivy--switch-buffer (workspace other)
  (let ((current (not other))
        prompt action filter update unwind)
    (cond ((and workspace current)
           (setq prompt "Switch to workspace buffer: "
                 action #'ivy--switch-buffer-action
                 filter #'+ivy--is-workspace-other-buffer-p))
          (workspace
           (setq prompt "Switch to workspace buffer in other window: "
                 action #'ivy--switch-buffer-other-window-action
                 filter #'+ivy--is-workspace-buffer-p))
          (current
           (setq prompt "Switch to buffer: "
                 action #'ivy--switch-buffer-action))
          ((setq prompt "Switch to buffer in other window: "
                 action #'ivy--switch-buffer-other-window-action)))
    (when +ivy-buffer-preview
      (cond ((not (and ivy-use-virtual-buffers
                       (eq +ivy-buffer-preview 'everything)))
             (setq update #'+ivy--switch-buffer-preview
                   unwind #'+ivy--switch-buffer-unwind))
            ((setq update #'+ivy--switch-buffer-preview-all
                   unwind #'+ivy--switch-buffer-unwind))))
    (ivy-read prompt 'internal-complete-buffer
              :action action
              :predicate filter
              :update-fn update
              :unwind unwind
              :preselect (buffer-name (other-buffer (current-buffer)))
              :matcher #'ivy--switch-buffer-matcher
              :keymap ivy-switch-buffer-map
              ;; NOTE A clever disguise, needed for virtual buffers.
              :caller #'ivy-switch-buffer)))

;;;###autoload
(defun +ivy/switch-workspace-buffer (&optional arg)
  "Switch to another buffer within the current workspace.
If ARG (universal argument), open selection in other-window."
  (interactive "P")
  (+ivy--switch-buffer t arg))

;;;###autoload
(defun +ivy/switch-workspace-buffer-other-window ()
  "Switch another window to a buffer within the current workspace."
  (interactive)
  (+ivy--switch-buffer t t))

;;;###autoload
(defun +ivy/switch-buffer ()
  "Switch to another buffer."
  (interactive)
  (+ivy--switch-buffer nil nil))

;;;###autoload
(defun +ivy/switch-buffer-other-window ()
  "Switch to another buffer in another window."
  (interactive)
  (+ivy--switch-buffer nil t))

;;;###autoload
(defun +ivy/woccur ()
  "Invoke a wgrep buffer on the current ivy results, if supported."
  (interactive)
  (unless (window-minibuffer-p)
    (user-error "No completion session is active"))
  (require 'wgrep)
  (let ((caller (ivy-state-caller ivy-last)))
    (if-let (occur-fn (plist-get +ivy-edit-functions caller))
        (ivy-exit-with-action
         (lambda (_) (funcall occur-fn)))
      (if-let (occur-fn (plist-get ivy--occurs-list caller))
          (let ((buffer (generate-new-buffer
                         (format "*ivy-occur%s \"%s\"*"
                                 (if caller (concat " " (prin1-to-string caller)) "")
                                 ivy-text))))
            (with-current-buffer buffer
              (let ((inhibit-read-only t))
                (erase-buffer)
                (funcall occur-fn))
              (setf (ivy-state-text ivy-last) ivy-text)
              (setq ivy-occur-last ivy-last)
              (setq-local ivy--directory ivy--directory))
            (ivy-exit-with-action
             `(lambda (_)
                (pop-to-buffer ,buffer)
                (ivy-wgrep-change-to-wgrep-mode))))
        (user-error "%S doesn't support wgrep" caller)))))

;;;###autoload
(defun +ivy-yas-prompt-fn (prompt choices &optional display-fn)
  (yas-completing-prompt prompt choices display-fn #'ivy-completing-read))

;;;###autoload
(defun +ivy-git-grep-other-window-action (x)
  "Opens the current candidate in another window."
  (when (string-match "\\`\\(.*?\\):\\([0-9]+\\):\\(.*\\)\\'" x)
    (select-window
     (with-ivy-window
       (let ((file-name   (match-string-no-properties 1 x))
             (line-number (match-string-no-properties 2 x)))
         (find-file-other-window (expand-file-name file-name (ivy-state-directory ivy-last)))
         (goto-char (point-min))
         (forward-line (1- (string-to-number line-number)))
         (re-search-forward (ivy--regex ivy-text t) (line-end-position) t)
         (run-hooks 'counsel-grep-post-action-hook)
         (selected-window))))))

;;;###autoload
(defun +ivy-confirm-delete-file (x)
  (dired-delete-file x 'confirm-each-subdirectory))

;;
;;; Wrappers around `counsel-compile'

;;;###autoload
(defun +ivy/compile ()
  "Execute a compile command from the current buffer's directory."
  (interactive)
  ;; Fix unhelpful 'Couldn't find project root' error
  (letf! (defun counsel--compile-root ()
           (ignore-errors
             (funcall counsel--compile-root)))
    (counsel-compile default-directory)))

;;;###autoload
(defun +ivy/project-compile ()
  "Execute a compile command from the current project's root."
  (interactive)
  (counsel-compile (projectile-project-root)))

;;;###autoload
(defun +ivy/jump-list ()
  "Go to an entry in evil's (or better-jumper's) jumplist."
  (interactive)
  ;; REVIEW Refactor me
  (let (buffers)
    (unwind-protect
        (ivy-read "jumplist: "
                  (nreverse
                   (delete-dups
                    (delq
                     nil
                     (mapcar (lambda (mark)
                               (when mark
                                 (cl-destructuring-bind (path pt _id) mark
                                   (let ((buf (get-file-buffer path)))
                                     (unless buf
                                       (push (setq buf (find-file-noselect path t))
                                             buffers))
                                     (with-current-buffer buf
                                       (goto-char pt)
                                       (font-lock-fontify-region (line-beginning-position) (line-end-position))
                                       (cons (format "%s:%d: %s"
                                                     (buffer-name)
                                                     (line-number-at-pos)
                                                     (string-trim-right (or (thing-at-point 'line) "")))
                                             (point-marker)))))))
                             (cddr (better-jumper-jump-list-struct-ring
                                    (better-jumper-get-jumps (better-jumper--get-current-context))))))))
                  :sort nil
                  :require-match t
                  :action (lambda (cand)
                            (let ((mark (cdr cand)))
                              (delq! (marker-buffer mark) buffers)
                              (mapc #'kill-buffer buffers)
                              (setq buffers nil)
                              (with-current-buffer (switch-to-buffer (marker-buffer mark))
                                (goto-char (marker-position mark)))))
                  :caller '+ivy/jump-list)
      (mapc #'kill-buffer buffers))))

;;;###autoload
(defun +ivy/git-grep-other-window-action ()
  "Open the current counsel-{ag,rg,git-grep} candidate in other-window."
  (interactive)
  (ivy-set-action #'+ivy-git-grep-other-window-action)
  (setq ivy-exit 'done)
  (exit-minibuffer))