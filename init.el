(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

;; Disable emacs font set
;; Set font depends on system
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 181 :width normal :foundry "unknown" :family "Inconsolata")))))


;; When MacOS, Adjust the font size.
(when (string-equal system-type "darwin") (set-default-font "Inconsolata 26"))
;; When Ubuntu, 24 size
(when (string-equal system-type "gnu/linux") (set-default-font "Inconsolata 24"))


;;;;;;;;;;;;; Google Internal Use ;;;;;;;;;;;;;
(when (require 'google nil 'noerror)
  (progn
    ;; (require 'google)
    ;; (require 'google-java)
    ;; (require 'p4-google)                ;; g4-annotate, improves find-file-at-point
    ;; (require 'compilation-colorization) ;; colorizes output of (i)grep
    (require 'googlemenu)               ;; handy Google menu bar
    (require 'google3-build)            ;; support for blaze builds
    (require 'csearch)                  ;; Search the whole Google code base.
    (require 'google-imports)
    (require 'ffap-java)
    ;;
    (grok-init)
    (setq grok-sloppy-editing nil)
    ;;
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
    ;;
    ;; Turn on red highlighting for characters outside of the 80/100 char limit
    (add-hook 'c++-mode-hook
	      '(lambda () (font-lock-set-up-width-warning 80)))
    (add-hook 'java-mode-hook
	      '(lambda () (font-lock-set-up-width-warning 100)))
    (add-hook 'js-mode-hook
	      '(lambda () (font-lock-set-up-width-warning 80)))
    (add-hook 'python-mode-hook
	      '(lambda () (font-lock-set-up-width-warning 80)))
    (add-hook 'sawzall-mode-hook
	      '(lambda () (font-lock-set-up-width-warning 80)))
    (add-hook 'sh-mode-hook
	      '(lambda () (font-lock-set-up-width-warning 80)))
    ;;
    ;;
    ;;
    ;; Suppress the trailing empty to be shown in RED
    (setq google-trailing-whitespace-modes '())
    (message "Suppressed trailing empty space red mode")
    ;;
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

;;;;;; Global viriables
;;
;;

;;; make completion buffers disappear after 3 seconds.
;; (add-hook 'completion-setup-hook
;;   (lambda () (run-at-time 3 nil
;;     (lambda () (delete-windows-on "*Completions*")))))

;;; make typing overwrite text selection
(delete-selection-mode t)

;;; Disable what? forgot
(put 'scroll-left 'disabled nil)

;;; Shut up compile saves
(setq compilation-ask-about-save nil)

;;; Enable erase buffer
(put 'erase-buffer 'disabled nil)

;;
;;
;;;;;;


;;;;;; Packages
;;
;;
(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

(require 'smart-tab)
(global-smart-tab-mode 1)

(require 'ido)
(require 'ido-ubiquitous)
(require 'smex)
(ido-mode t)
(ido-ubiquitous-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(smex-initialize)

(require 'kill-ring-ido)
(global-set-key (kbd "C-M-y") 'kill-ring-ido)

(require 'visual-regexp)
(require 'visual-regexp-steroids)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s

(require 'smooth-scrolling)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;
;;
;;
;;;;;;

;; ;;; auto-save
;; ;; automatically save buffers associated with files on buffer switch
;; ;; and on windows switch
;; (defadvice switch-to-buffer (before save-buffer-now activate)
;;   (when buffer-file-name (save-buffer)))
;; (defadvice other-window (before other-window-now activate)
;;   (when buffer-file-name (save-buffer)))
;; (defadvice windmove-up (before other-window-now activate)
;;   (when buffer-file-name (save-buffer)))
;; (defadvice windmove-down (before other-window-now activate)
;;   (when buffer-file-name (save-buffer)))
;; (defadvice windmove-left (before other-window-now activate)
;;   (when buffer-file-name (save-buffer)))
;; (defadvice windmove-right (before other-window-now activate)
;;   (when buffer-file-name (save-buffer)))


;;;;;;;;;; Smart Copy/Kill Current Line
;;
;;

(defun my-smart-copy-kill-selector ()
  "Smartly select current object to be copied or killed based on context.
return a 2-tuple-list."
  (if mark-active
      (progn (message "Copied region") (list (region-beginning) (region-end)))
    ;; else 1
    (if (and (not (equal (point) (line-beginning-position))) (bounds-of-thing-at-point 'symbol))
	(progn (message "Copied symbol: %s" (thing-at-point 'symbol)) (list (car (bounds-of-thing-at-point 'symbol)) (cdr (bounds-of-thing-at-point 'symbol))))
      ;; else 2
      (progn (message "Copied line: %s" (thing-at-point 'line)) (list (line-beginning-position) (line-end-position)))
      );; end of if 2
    );; end of if 1
  )

(defadvice kill-ring-save (before smart-copy-line activate compile)
  "When called interactively with no active region, copy a single line or a a word instead."
  (interactive (my-smart-copy-kill-selector))
  )


(defadvice kill-region (before smart-kill-line activate compile)
  "Same as above."
  (interactive (my-smart-copy-kill-selector))
  )
;;
;;
;;;;;;;;;;


;;;;;;;;;; Fast switch to last buffer
;;
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(keyboard-translate ?\C-q ?\H-q)
(global-set-key [?\H-q] 'switch-to-previous-buffer)
;;
;;;;;;;;;;


;;;;;;;;;; Make scrolling move cursors
;;
(defun sfp-page-down ()
  (interactive)
  (setq this-command 'next-line)
  (next-line
   (- (window-text-height)
      next-screen-context-lines)))

(defun sfp-page-up ()
  (interactive)
  (setq this-command 'previous-line)
  (previous-line
   (- (window-text-height)
      next-screen-context-lines)))

(global-set-key [next] 'sfp-page-down)
(global-set-key [prior] 'sfp-page-up)
;;
;;;;;;;;;;


(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

;; ~~~~~
;;;; Other window override all
(define-key my-keys-minor-mode-map (kbd "C-o") 'other-window)
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 3)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 3)))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-k") 'kill-buffer-and-window)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x f") 'dired)
(define-key my-keys-minor-mode-map (kbd "C-z") 'smex)
(define-key my-keys-minor-mode-map (kbd "C-x C-x") 'smex)

;; (define-key my-keys-minor-mode-map (kbd "M-p") 'previous-line)
;; (define-key my-keys-minor-mode-map (kbd "M-;") 'next-line)
;; (define-key my-keys-minor-mode-map (kbd "M-l") 'backward-char)
;; (define-key my-keys-minor-mode-map (kbd "M-'") 'forward-char)
;; (define-key my-keys-minor-mode-map (kbd "M-o") 'move-beginning-of-line)
;; (define-key my-keys-minor-mode-map (kbd "M-[") 'move-end-of-line)
;; (define-key my-keys-minor-mode-map (kbd "M-p") 'backward-paragraph)
;; (define-key my-keys-minor-mode-map (kbd "M-;") 'forward-paragraph)
;; (define-key my-keys-minor-mode-map (kbd "M-l") 'backward-word)
;; (define-key my-keys-minor-mode-map (kbd "M-'") 'forward-word)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " ning-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode t)
;;;;

;;;; Always show file path in frame title
;;
;;
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
	    '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))


(custom-set-faces
'(rainbow-delimiters-depth-1-face ((t (:foreground "hot pink"))))
'(rainbow-delimiters-depth-2-face ((t (:foreground "magenta"))))
'(rainbow-delimiters-depth-3-face ((t (:foreground "#ff7f00"))))
'(rainbow-delimiters-depth-4-face ((t (:foreground "#FFFF00"))))
'(rainbow-delimiters-depth-5-face ((t (:foreground "#00FF00"))))
'(rainbow-delimiters-depth-6-face ((t (:foreground "#0000FF"))))
'(rainbow-delimiters-depth-7-face ((t (:foreground "#4B0082"))))
'(rainbow-delimiters-depth-8-face ((t (:foreground "#8B00FF")))))
