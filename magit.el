;; Magit AND OTHER GIT STUFF
(use-package magit :ensure t)
;;(use-package forge :ensure t)
(setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
(define-key global-map (kbd "C-x g") 'magit)
