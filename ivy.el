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
