(require 'init-elpa)

(use-package go-mode)
(use-package company-go
  :after (go-mode company))

(setenv "GOPATH" "/home/mkulkarni/go/")
(add-to-list 'exec-path "/home/mkulkarni/go/bin")

(defun my-go-mode-hook ()
  (require 'company)
  (require 'company-go)
  ; Call Gofmt before saving                                                    
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  (set (make-local-variable 'compile-command)
       (format "go run %s" (file-name-nondirectory buffer-file-name)))
  (auto-complete-mode 1)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
