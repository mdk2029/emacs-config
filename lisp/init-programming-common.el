(require 'init-elpa)

(use-package company
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.3)
  (global-set-key (kbd "C-<ret>") 'company-complete))
(require 'company)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck
  :hook (prog-mode . flycheck-mode))
(require 'flycheck)

(use-package popup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package which-key
  :config
  (which-key-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package lsp-mode
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  ;;:init (setq lsp-keymap-prefix "s-l")
  :commands lsp
  :hook
  ((rust-mode) . lsp)
  :config
  (message "lsp-mode LOADED")
  (setq lsp-prefer-flymake nil)
  (use-package lsp-ui
    :ensure t
    :requires lsp-mode flycheck
    :commands lsp-ui-mode
    :config
    (message "lsp-ui mode LOADED")
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-doc-use-childframe t)
    (setq lsp-ui-doc-position 'top)
    (setq lsp-ui-doc-include-signature t)
    (setq lsp-ui-sideline-enable t)
    (setq lsp-ui-sideline-ignore-duplicate t)
    (setq lsp-ui-sideline-show-symbol t)
    (setq lsp-ui-sideline-show-hover t)
    (setq lsp-ui-flycheck-enable t)
    (setq lsp-ui-flycheck-list-position 'right)
    (setq lsp-ui-flycheck-live-reporting t)
    (setq lsp-ui-peek-enable t)
    (setq lsp-ui-peek-list-width 60)
    (setq lsp-ui-peek-peek-height 25)
    (mapcar (lambda (f) (set-face-foreground f "dim gray"))
	    '(lsp-ui-sideline-code-action lsp-ui-sideline-current-symbol lsp-ui-sideline-symbol lsp-ui-sideline-symbol-info))
    (defun my/toggle-lsp-ui-doc ()
      (interactive)
      (if lsp-ui-doc-mode
	  (progn
	    (lsp-ui-doc-mode -1)
	    (lsp-ui-doc--hide-frame))
	(progn
	  (lsp-ui-doc-mode 1)
	  (lsp-ui-doc-show)))))
  :bind
  (:map lsp-mode-map
	("C-c C-r" . lsp-ui-peek-find-references)
	("C-c C-j" . lsp-ui-peek-find-definitions)
	("C-c i"   . lsp-ui-peek-find-implementation)
	("C-c m"   . lsp-ui-imenu)
	("C-c s"   . lsp-ui-sideline-mode)
	("C-c d"   . my/toggle-lsp-ui-doc))
  )
  
;;(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(use-package company-lsp
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
;; Disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))

;; ;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; ;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(provide 'init-programming-common)
