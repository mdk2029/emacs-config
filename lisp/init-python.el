(require 'init-elpa)

(use-package elpy)
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")
(setq-default python-indent 4)
(setq-default python-indent-offset 4)
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4)))
;;(setq-default pdb-command-name "python3 -m pdb")

(setq elpy-rpc-python-command "python3")
(setq elpy-rpc-backend "jedi")

(elpy-enable)

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(provide 'init-python)
