(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes nil)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

;; Set font depends on system
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 170 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


;;;;;;;;;;;;; Google Internal Use ;;;;;;;;;;;;;
(when (require 'google nil 'noerror)
  (progn
    (require 'google)
    (require 'google-java)
    ;; (require 'p4-google)                ;; g4-annotate, improves find-file-at-point
    ;; (require 'compilation-colorization) ;; colorizes output of (i)grep
    (require 'googlemenu)               ;; handy Google menu bar
    (require 'google3-build)            ;; support for blaze builds
    (require 'csearch)                  ;; Search the whole Google code base.
    (require 'google-imports)
    (require 'ffap-java)
    ;;
    (grok-init)
    ;;
    (setq google-build-system "blaze")
    ;;
    ;;
    ;;make chrome the default browser
    (setq browse-url-browser-function 'browse-url-generic
	  browse-url-generic-program "google-chrome")
    ;;
    ;;allow navigation of dashcase/camelCase etc word at a time( awesome for deleting parts of  a variable name Hit Alt+D and it will delete only a subword.
    (add-hook 'c-mode-common-hook
	      (lambda () (subword-mode 1)))
    ;;
    ;; Enable auto organizing of imports on save
    (add-hook 'java-mode-hook
	      '(lambda ()
		 (add-hook 'write-contents-functions 'google-imports-organize-imports)))
    ;;
    )
  )
;;;;;;;;;;;;; Google Internal Use ;;;;;;;;;;;;;



;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
;; create the autosave dir if necessary, since emacs won't.

(defvar my-autosaves-dir "~/.emacs.d.autosaves")
(make-directory my-autosaves-dir t)
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/.emacs.d.autosaves"))
 delete-old-version t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)


;;; make typing overwrite text selection
(delete-selection-mode 1)

;;; Disable what? forgot
(put 'scroll-left 'disabled nil)

;;; Shut up compile saves
(setq compilation-ask-about-save nil)

;;; Packages
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")

(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

(require 'smart-tab)
(global-smart-tab-mode 1)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;;; auto-save
;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))



;;;;;;;;;; Global key binding
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "<f7>") 'compile)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x f") 'dired)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
;;;;;;;;;;
