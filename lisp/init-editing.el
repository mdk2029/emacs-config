(require 'init-elpa)

(use-package saveplace)
(use-package rainbow-delimiters)
;;(require-package 'flycheck)

(setq create-lockfiles nil)
(setq inhibit-startup-message t) ;; hide the startup message
(setq inhibit-splash-screen t) ;; hide the startup message
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

(show-paren-mode t)
;; Overwrite region selected
(delete-selection-mode t)
;; Prevent emacs from creating a bckup file filename~
(setq make-backup-files nil)
;; Settings for searching
(setq-default case-fold-search t ;case insensitive searches by default
              search-highlight t) ;hilit matches when searching

;; ;; Disable the toolbar at the top since it's useless
;; (if (functionp 'tool-bar-mode) (tool-bar-mode -1))

;; We don't want to type yes and no all the time so, do y and n
(defalias 'yes-or-no-p 'y-or-n-p)
;; Disable the horrid auto-save
(setq auto-save-default nil)

;; ;; Disable the menu bar since we don't use it, especially not in the
;; ;; terminal
;; (when (and (not (eq system-type 'darwin)) (fboundp 'menu-bar-mode))
;;   (menu-bar-mode -1))

;; Don't ring the bell
(setq ring-bell-function 'ignore)

;; Non-nil means draw block cursor as wide as the glyph under it.
;; For example, if a block cursor is over a tab, it will be drawn as
;; wide as that tab on the display.
(setq x-stretch-cursor t)

(setq-default indent-tabs-mode nil)

;; (global-linum-mode t)
;; ;; Show column numbers by default
;; (setq column-number-mode t)
;; ;; Highlight current line
;; (global-hl-line-mode 1)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(define-key global-map (kbd "RET") 'newline-and-indent)

;;(add-hook 'after-init-hook #'global-flycheck-mode)

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace

(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files. This tells Emacs to
;; put all backups in ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)

(defun toggle-comment-on-line ()
  "Comment or uncomment current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package async)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package whitespace
  :ensure t
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function global-whitespace-mode "whitespace.el"))
  :config
  (setq whitespace-style '(tabs tab-mark))
  ;; Turn on whitespace mode globally
  (global-whitespace-mode t)
  :delight global-whitespace-mode
  )

(provide 'init-editing)
