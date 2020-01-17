;; Company
(use-package company :ensure t)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-limit 10)
(setq company-idle-delay .1)
(setq company-tooltip-align-annotations t)
(setq doom-modeline-buffer-encoding nil)
