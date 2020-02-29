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

(defvar myPackages
  '(use-package
     bind-key
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(provide 'init-elpa)
