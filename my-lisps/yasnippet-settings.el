;; -*- Emacs-Lisp -*-

;; Time-stamp: <2011-09-30 16:50:33 Friday by ldw>


(require 'yasnippet-bundle)
(require 'yasnippet) ;; not yasnippet-bundle

(yas/initialize)
(yas/load-directory (concat my-emacs-path "lisps/yasnippet/snippets"))
(yas/global-mode 1)

(defun yasnippet-settings ()
  "settings for `yasnippet'."
  (setq yas/root-directory (concat my-emacs-path "snippets"))

  (defun yasnippet-unbind-trigger-key ()
    "Unbind `yas/trigger-key'."
    (let ((key yas/trigger-key))
      (setq yas/trigger-key nil)
      (yas/trigger-key-reload key)))

  (yasnippet-unbind-trigger-key)
  
;;;###autoload
  (defun yasnippet-reload-after-save ()
    (let* ((bfn (expand-file-name (buffer-file-name)))
           (root (expand-file-name yas/root-directory)))
      (when (string-match (concat "^" root) bfn)
        (yas/load-snippet-buffer))))
  (add-hook 'after-save-hook 'yasnippet-reload-after-save))

(eal-define-keys
 'yas/keymap
 `(("M-j"     yas/next-field-or-maybe-expand)
   ("M-k"     yas/prev-field)))

(eal-define-keys
 'yas/minor-mode-map
 `(("C-c C-f" yas/find-snippets)))

(eval-after-load "yasnippet"
  `(yasnippet-settings))

(yas/load-directory yas/root-directory)

(provide 'yasnippet-settings)
