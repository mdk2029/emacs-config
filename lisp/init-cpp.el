(require 'init-elpa)
(require 'google-c-style)

;; (setq c-basic-offset 4)
;; (setq tab-width 4)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.H\\'" . c++-mode))

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'font-lock-mode)
(add-hook 'c-mode-common-hook
          (lambda () (define-key c-mode-base-map (kbd "C-c 0") 'recompile)))

;;(setq-default c-default-style "stroustrup")
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard
                                          "c++17")))

(require 'cc-mode)
(define-key c-mode-base-map
  (kbd "C-i")
  'clang-format)



(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(provide 'init-cpp)
