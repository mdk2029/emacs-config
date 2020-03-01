;; .emacs.d/init.el

(setq user-full-name "MK"
      user-mail-address "mdk.2029@gmail.com")

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-elpa)
(require 'init-exec-path)
(require 'init-ui)
(require 'init-editing)
(require 'init-navigation)
(require 'init-programming-common)
(require 'init-cpp)
(require 'init-python)
(require 'init-rust)
(require 'init-go)

;;(require-package 'better-defaults)

(require 'server)
(if (not (server-running-p)) (server-start))

(provide 'init)

;; User-Defined init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elpy smex rainbow-delimiters material-theme golden-ratio flycheck exec-path-from-shell company better-defaults atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
