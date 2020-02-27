(require 'init-elpa)
(require 'ido)
(require 'recentf)
;;(require-package 'ido-ubiquitous)
(use-package smex)
(use-package projectile)

(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(recentf-mode 1)
(setq recentf-max-menu-items 40)

(ido-mode t)

;;show choices vertically
;; show choices vertically
(if (version< emacs-version "25")
    (progn
      (make-local-variable 'ido-separator)
      (setq ido-separator "\n"))
  (progn
    (make-local-variable 'ido-decorations)
    (setf (nth 2 ido-decorations) "\n")))

;; show any name that has the chars you typed
(setq ido-enable-flex-matching t)
;; use current pane for newly opened file
(setq ido-default-file-method 'selected-window)
;; use current pane for newly switched buffer
(setq ido-default-buffer-method 'selected-window)
;; stop ido from suggesting when naming new file
(when (boundp 'ido-minor-mode-map-entry)
  (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil))

(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-use-virtual-buffers t)

;;(ido-ubiquitous-mode 1)

;; Shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(projectile-global-mode)

;; Enable move point from window to window using Shift and the arrow keys
(windmove-default-keybindings)

(provide 'init-navigation)
