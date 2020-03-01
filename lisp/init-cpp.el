(require 'init-elpa)

(setq c-basic-offset 4)
(setq tab-width 4)
(setq-default c-default-style "stroustrup")
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++17")))

(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(provide 'init-cpp)
