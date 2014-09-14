(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

;; Disable emacs font set
;; Set font depends on sys;; tem
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 181 :width normal :foundry "unknown" :family "Inconsolata")))))


;; When MacOS, Adjust the font size.
(when (string-equal system-type "darwin") (set-default-font "Inconsolata 26"))

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

;;; Packages
(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

(require 'smart-tab)
(global-smart-tab-mode 1)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)


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



;;;;;;;;;; Smart Parens
;;
;;
(defun move-forward-paren (&optional arg)
  "Move forward parenthesis"
  (interactive "P")
  (if (looking-at ")") (forward-char 1))
  (while (not (looking-at ")")) (forward-char 1))
  )

(defun move-backward-paren (&optional arg)
  "Move backward parenthesis"
  (interactive "P")
  (if (looking-at "(") (forward-char -1))
  (while (not (looking-at "(")) (backward-char 1))
  )

(defun move-forward-sqrParen (&optional arg)
  "Move forward square brackets"
  (interactive "P")
  (if (looking-at "]") (forward-char 1))
  (while (not (looking-at "]")) (forward-char 1))
  )

(defun move-backward-sqrParen (&optional arg)
  "Move backward square brackets"
  (interactive "P")
  (if (looking-at "[[]") (forward-char -1))
  (while (not (looking-at "[[]")) (backward-char 1))
  )

(defun move-forward-curlyParen (&optional arg)
  "Move forward curly brackets"
  (interactive "P")
  (if (looking-at "}") (forward-char 1))
  (while (not (looking-at "}")) (forward-char 1))
  )

(defun move-backward-curlyParen (&optional arg)
  "Move backward curly brackets"
  (interactive "P")
  (if (looking-at "{") (forward-char -1))
  (while (not (looking-at "{")) (backward-char 1))
  )

(defun move-forward-angleParen (&optional arg)
  "Move forward angle brackets"
  (interactive "P")
  (if (looking-at ">") (forward-char 1))
  (while (not (looking-at ">")) (forward-char 1))
  )

(defun move-backward-angleParen (&optional arg)
  "Move backward angle brackets"
  (interactive "P")
  (if (looking-at "<") (forward-char -1))
  (while (not (looking-at "<")) (backward-char 1))
  )

(global-set-key (kbd "M-)")           (quote move-forward-paren))
(global-set-key (kbd "M-(")           (quote move-backward-paren))
(global-set-key (kbd "M-]")           (quote move-forward-sqrParen))
(global-set-key (kbd "M-[")           (quote move-backward-sqrParen))
(global-set-key (kbd "M-}")           (quote move-forward-curlyParen))
(global-set-key (kbd "M-{")           (quote move-backward-curlyParen))
(global-set-key (kbd "M->")           (quote move-forward-angleParen))
(global-set-key (kbd "M-<")           (quote move-backward-angleParen))

;;
;;
;;;;;;;;;; Smart Parens

;;;;;;;;;; Smart Copy/Kill Current Line
;;
;;
(defadvice kill-ring-save (before smart-copy-line activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message
  "Copied line") (list (line-beginning-position) (line-beginning-position
  2)))))

(defadvice kill-region (before smart-kill-line activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))
;;
;;
;;;;;;;;;;

;;;;;;;;;; Global key binding
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "<f7>") 'compile)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x f") 'dired)
(global-set-key (kbd "C-x C-k") 'kill-buffer-and-window)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
;;;;;;;;;;
