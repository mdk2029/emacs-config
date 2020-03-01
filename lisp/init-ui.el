(require 'init-elpa)

(cond
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (message "Mac OS X")
    (use-package atom-one-dark-theme
      :ensure t
      :config
      (load-theme 'atom-one-dark t))
    (use-package golden-ratio
      :ensure t
      :config
      (golden-ratio-mode 1))
    (set-face-attribute 'default nil :height 140)
    (setq-default line-spacing 0.4)
    ))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux")
    (use-package solarized-theme
      :ensure t
      :config
      (load-theme 'solarized-dark t))
    )))


(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

(global-hl-line-mode +1)
(global-linum-mode t)
;;(line-number-mode +1)
;;(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

(setq inhibit-startup-screen t)

;; modeline munging
(use-package diminish)
(use-package delight)
(diminish 'abbrev-mode)

;; better looking modelines
(use-package powerline
  :config (powerline-default-theme))

;; (global-linum-mode t)
;; (menu-bar-mode -1)
;; (when (fboundp 'tool-bar-mode)
;;   (tool-bar-mode -1))
;; (when (fboundp 'scroll-bar-mode)
;;   (scroll-bar-mode -1))

(setq
      x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t)

;; (blink-cursor-mode 0)
;; (setq-default cursor-type 'bar)
;; (set-cursor-color "#cccccc")

(provide 'init-ui)
