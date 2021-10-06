(require 'init-elpa)

(add-hook 'prog-mode-hook #'auto-fill-mode)

(use-package company
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t)
  (setq lsp-completion-provider :capf)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.3)
  (global-set-key (kbd "C-<ret>") 'company-complete))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :delight
  :config
  (setq flycheck-gcc-language-standard "c++17")
  (setq flycheck-clang-language-standard "c++17")
  )
  
(use-package popup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package which-key
  :config (which-key-mode)
  :delight
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package magit
  :bind (("C-M-g" . magit-status)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package lsp-mode
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   ;;:init (setq lsp-keymap-prefix "s-l")
;;   :diminish "L"  
;;   :commands lsp
;;   :hook
;;   ((rust-mode) . lsp)
;;   :config
;;   (message "lsp-mode LOADED")
;;   (setq lsp-prefer-flymake nil)
;;   (use-package lsp-ui
;;     :ensure t
;;     :requires lsp-mode flycheck
;;     :commands lsp-ui-mode
;;     :config
;;     (message "lsp-ui mode LOADED")
;;     (setq lsp-ui-doc-enable nil)
;;     (setq lsp-ui-doc-use-childframe t)
;;     (setq lsp-ui-doc-position 'top)
;;     (setq lsp-ui-doc-include-signature t)
;;     (setq lsp-ui-sideline-enable t)
;;     (setq lsp-ui-sideline-ignore-duplicate t)
;;     (setq lsp-ui-sideline-show-symbol t)
;;     (setq lsp-ui-sideline-show-hover t)
;;     (setq lsp-ui-flycheck-enable t)
;;     (setq lsp-ui-flycheck-list-position 'right)
;;     (setq lsp-ui-flycheck-live-reporting t)
;;     (setq lsp-ui-peek-enable t)
;;     (setq lsp-ui-peek-list-width 60)
;;     (setq lsp-ui-peek-peek-height 25)
;;     (setq lsp-enable-file-watchers nil)
;;     (setq lsp-enable-on-type-formatting nil)
;;     (setq lsp-enable-snippet nil)    
;;     (mapcar (lambda (f) (set-face-foreground f "dim gray"))
;; 	    '(lsp-ui-sideline-code-action lsp-ui-sideline-current-symbol lsp-ui-sideline-symbol lsp-ui-sideline-symbol-info))
;;     (defun my/toggle-lsp-ui-doc ()
;;       (interactive)
;;       (if lsp-ui-doc-mode
;; 	  (progn
;; 	    (lsp-ui-doc-mode -1)
;; 	    (lsp-ui-doc--hide-frame))
;; 	(progn
;; 	  (lsp-ui-doc-mode 1)
;; 	  (lsp-ui-doc-show)))))
;;   :bind
;;   (:map lsp-mode-map
;; 	("C-c C-r" . lsp-ui-peek-find-references)
;; 	("C-c C-j" . lsp-ui-peek-find-definitions)
;; 	("C-c i"   . lsp-ui-peek-find-implementation)
;; 	("C-c m"   . lsp-ui-imenu)
;; 	("C-c s"   . lsp-ui-sideline-mode)
;; 	("C-c d"   . my/toggle-lsp-ui-doc))
;;   )

(use-package lsp-mode
  :diminish (lsp-mode . "lsp")
  :bind (:map lsp-mode-map
    ("C-c C-d" . lsp-describe-thing-at-point))
  :hook ((python-mode . #'lsp-deferred)
    (js-mode . #'lsp-deferred)
    (go-mode-hook . #'lsp-deferred)
    (rust-mode . #'lsp-deferred)    
    )
  :init
  (setq lsp-auto-guess-root t       ; Detect project root
   lsp-log-io nil
   lsp-enable-indentation t
   lsp-enable-imenu t
   lsp-keymap-prefix "C-l"
   lsp-file-watch-threshold 500
   lsp-enable-file-watchers nil
   lsp-enable-on-type-formatting nil
   lsp-enable-snippet nil    
   lsp-prefer-flymake nil)      ; Use lsp-ui and flycheck

  (defun lsp-on-save-operation ()
    (when (or (boundp 'lsp-mode)
         (bound-p 'lsp-deferred))
      (lsp-organize-imports)
      (lsp-format-buffer))))

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :commands lsp-ui-doc-hide
  :bind (:map lsp-ui-mode-map
         ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
         ([remap xref-find-references] . lsp-ui-peek-find-references)
         ("C-c u" . lsp-ui-imenu))
  :init (setq lsp-ui-doc-enable t
         lsp-ui-doc-use-webkit nil
         lsp-ui-doc-header nil
         lsp-ui-doc-delay 0.2
         lsp-ui-doc-include-signature t
         lsp-ui-doc-alignment 'at-point
         lsp-ui-doc-use-childframe nil
         lsp-ui-doc-border (face-foreground 'default)
         lsp-ui-peek-enable t
         lsp-ui-peek-show-directory t
         lsp-ui-sideline-update-mode 'line
         lsp-ui-sideline-enable t
         lsp-ui-sideline-show-code-actions t
         lsp-ui-sideline-show-hover nil
         lsp-ui-sideline-ignore-duplicate t)
  :config
  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  (add-hook 'after-load-theme-hook
       (lambda ()
         (setq lsp-ui-doc-border (face-foreground 'default))
         (set-face-background 'lsp-ui-doc-background
                              (face-background 'tooltip))))

  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))
  
;;(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; Disable client-side cache because the LSP server does a better job.
(setq company-transformers nil
      company-lsp-async t
      company-lsp-cache-candidates nil)

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :ensure t
  :commands lsp-treemacs-errors-list
  :bind (:map lsp-mode-map
         ("M-9" . lsp-treemacs-errors-list)))

(use-package treemacs
  :ensure t
  :commands (treemacs)
  :after (lsp-mode))

(use-package clang-format
  :config
  (setq clang-format-style "file"))

;; ;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; ;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(provide 'init-programming-common)
