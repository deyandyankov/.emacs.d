;;(set-frame-font "Hack Regular Nerd Font Complete")
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(delete-selection-mode 1)

;; enable C-x C-u to uppercase text
(put 'upcase-region 'disabled nil)
;; enable C-x C-l to lowercase text
(put 'downcase-region 'disabled nil)

(setq delete-old-versions -1 )
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) )
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) )
(setq ring-bell-function 'ignore )
(setq coding-system-for-read 'utf-8 )
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)
(setq default-fill-column 80)
(setq compilation-scroll-output t)

(global-set-key (kbd "M-a") 'goto-line)
(global-set-key (kbd "C-c r") 'anzu-query-replace-regexp)
(global-set-key (kbd "M-[") 'sp-backward-unwrap-sexp)
(global-set-key (kbd "M-]") 'sp-unwrap-sexp)
(global-set-key (kbd "M-p") 'smartparens-strict-mode)
