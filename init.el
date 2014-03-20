(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 143 :width normal :foundry "unknown" :family "Consolas")))))

;;; ~~~

(put 'scroll-left 'disabled nil)
;;; Shut up compile saves
(setq compilation-ask-about-save nil)

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "<f7>") 'compile)


;;; Packages

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")

(require 'yasnippet)
(yas-global-mode 1)

(require  'window-number)
(window-number-mode)
(window-number-meta-mode)
