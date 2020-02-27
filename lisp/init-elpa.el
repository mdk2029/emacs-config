(require 'package)

;; (defun require-package (package)
;;   "Install given PACKAGE if it was not installed before."
;;   (if (package-installed-p package)
;;       t
;;     (progn
;;       (unless (assoc package package-archive-contents)
;; 	(package-refresh-contents))
;;       (package-install package))))

(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives
;;	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/"))

;;(setq package-enable-at-startup nil)
(package-initialize)

;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

(eval-when-compile (require 'use-package))

(provide 'init-elpa)
