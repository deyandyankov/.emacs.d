(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package doom-themes :ensure t)

(load-theme 'doom-nord t)
(load-file "~/.emacs.d/common.el")
(load-file "~/.emacs.d/orgmode.el")

;; MacOS Path Fix
(use-package exec-path-from-shell :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; UI
(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode))
(setq doom-modeline-buffer-encoding nil)

;; DASHBOARD
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-center-content t)
(setq dashboard-startup-banner '2)
(setq dashboard-items '((recents  . 5)
                        (projects . 5)
                        (bookmarks . 5)
                        (agenda . 5)))
                        
;; PROJECTILE
(use-package projectile :ensure t)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)

;; Company
(use-package company :ensure t)
(setq company-tooltip-limit 10) 
(setq company-idle-delay .1)
(setq company-tooltip-align-annotations t)
(add-hook 'after-init-hook 'global-company-mode)
(setq doom-modeline-buffer-encoding nil)

;; Flycheck
(use-package flycheck :ensure t)
(global-flycheck-mode t)

;; IVY
(use-package ivy :ensure t)
(use-package swiper :ensure t)
(global-set-key (kbd "C-s") 'swiper-isearch)
(ivy-mode 1)

(use-package all-the-icons :ensure t)
(use-package ivy-rich
  :ensure t
  :after ivy)

(defun ivy-rich-switch-buffer-icon (candidate)
  (with-current-buffer
      (get-buffer candidate)
    (let ((icon (all-the-icons-icon-for-mode major-mode)))
      (if (symbolp icon)
	  (all-the-icons-icon-for-mode 'fundamental-mode)
	icon))))

(setq ivy-rich-display-transformers-list
      '(ivy-switch-buffer
        (:columns
         ((ivy-rich-switch-buffer-icon :width 2)
          (ivy-rich-candidate (:width 20))
          (ivy-rich-switch-buffer-size (:width 0))
          (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
          (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
          (ivy-rich-switch-buffer-project (:width 15 :face success))
          (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
         :predicate
         (lambda (cand) (get-buffer cand)))))
(setq ivy-rich-path-style 'abbrev)
(ivy-rich-mode 1)

;; ACE WINDOWS

(use-package ace-window :ensure t)
(global-set-key (kbd "C-z") 'ace-window)

;; Magit AND OTHER GIT STUFF
(use-package magit :ensure t)
;;(use-package forge :ensure t)
(setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
(define-key global-map (kbd "C-x g") 'magit)

;;(use-package diff-hl :ensure t)
;;(global-diff-hl-mode)

;; yasnippets
(use-package yasnippet :ensure t)
(use-package yasnippet-snippets :ensure t)
(yas-global-mode 1)

;; Take care of trailing whitespaces
(use-package ws-butler :ensure t)
(add-hook 'prog-mode-hook #'ws-butler-mode)


;; expand-region
(use-package expand-region :ensure t)
(global-set-key (kbd "c-=") 'er/expand-region)

;; ace-jump-mode
(use-package ace-jump-mode :ensure t)
(define-key global-map (kbd "c-c ,") 'ace-jump-mode)

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


;; (use-package lsp-mode
;;   :ensure t
;;   :commands (lsp lsp-deferred)
;;   :hook (js-mode . lsp-deferred)
;;   :config
;;   (add-hook 'js-mode-hook (lambda () (setq js-indent-level 4)))
;;   (add-hook 'js-mode-hook (lambda () (setq tab-width 4))))

;; (use-package company-lsp :ensure t)
;; (push 'company-lsp company-backends)

;; duplicate thing
(use-package duplicate-thing :ensure t)
(global-set-key (kbd "m-c") 'duplicate-thing)

(use-package json-mode :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by custom.
 ;; if you edit it by hand, you could mess it up, so be careful.
 ;; your init file should contain only one such instance.
 ;; if there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (json-mode duplicate-thing smartparens markdown-mode anzu ag ace-jump-mode expand-region ws-butler yasnippet-snippets yasnippet magit ace-window ivy-rich swiper ivy flycheck company projectile dashboard doom-modeline exec-path-from-shell doom-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by custom.
 ;; if you edit it by hand, you could mess it up, so be careful.
 ;; your init file should contain only one such instance.
 ;; if there is more than one, they won't work right.
 )
