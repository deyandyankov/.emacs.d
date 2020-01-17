(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(load-file "~/.emacs.d/doomthemes.el")
(load-file "~/.emacs.d/common.el")
(load-file "~/.emacs.d/orgmode.el")
(load-file "~/.emacs.d/macospathfix.el")
(load-file "~/.emacs.d/ui.el")
(load-file "~/.emacs.d/dashboard.el")
(load-file "~/.emacs.d/projectile.el")
(load-file "~/.emacs.d/company.el")
(load-file "~/.emacs.d/flycheck.el")
(load-file "~/.emacs.d/ivy.el")
(load-file "~/.emacs.d/acewindows.el")
(load-file "~/.emacs.d/magit.el")
(load-file "~/.emacs.d/wsbutler.el") ;; take care of trailing whitespaces

;; expand-region
(use-package expand-region :ensure t)
(global-set-key (kbd "C-=") 'er/expand-region)

;; ace-jump-mode
(use-package ace-jump-mode :ensure t)
(define-key global-map (kbd "C-c ,") 'ace-jump-mode)

;;ag.el
(use-package ag :ensure t)

;;anzu.el
(use-package anzu :ensure t)
(global-anzu-mode +1)

;; markdown
(use-package markdown-mode
  :ensure t
  :mode (("readme\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; (use-package cider :ensure t)
;; (cider-auto-test-mode 1)

(use-package smartparens :ensure t)

(use-package smartparens-config
  :ensure smartparens
  :config (progn (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

;; duplicate thing
(use-package duplicate-thing :ensure t)
(global-set-key (kbd "M-c") 'duplicate-thing)


;; JULIA
(use-package dash)
(use-package lsp-mode
  :init
  ;; Use flycheck instead of flymake (better lsp-ui integration)
  (setq lsp-prefer-flymake nil)

  :config
  ;; Prevent long documentation showing up in the echo area from messing up the
  ;; window configuration -> only show the first line
  (defun ff/lsp-eldoc-advice (orig-fun &rest args)
    (let ((msg (car args)))
      (if msg
          (funcall orig-fun (->> msg (s-trim-left)
                                     (s-split "\n")
                                     (first))))))
  (advice-add 'lsp--eldoc-message :around #'ff/lsp-eldoc-advice)

  ;; Avoid questions about restarting the LSP server when quitting emacs
  (defun ff/lsp-disable-server-autorestart ()
    (setq lsp-restart nil))
  (add-hook 'kill-emacs-hook #'ff/lsp-disable-server-autorestart))
(use-package lsp-ui
  :ensure t

  :init
  (setq lsp-ui-doc-enable nil)

  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references]  #'lsp-ui-peek-find-references))
;; I've installed lsp-julia as a git submodule of my emacs configuration directory
(use-package lsp-julia
  :load-path (lambda () (expand-file-name "~/.emacs.d/lsp-julia")))
(add-hook 'julia-mode-hook #'lsp-mode)

;; json
(use-package json-mode :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cdlatex plantuml-mode vterm julia-repl lsp-ui json-mode duplicate-thing smartparens markdown-mode anzu ag ace-jump-mode expand-region ws-butler yasnippet-snippets yasnippet magit ace-window ivy-rich swiper ivy flycheck company projectile dashboard doom-modeline exec-path-from-shell doom-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
