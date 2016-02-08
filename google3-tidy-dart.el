(defun google3-tidy-dart ()
  "Run tidy_dart on current file. tidy_dart is a tool that
automatically re-orders imports and sets library names as
recommended by the style guide."
  (interactive)
  (unless (eq major-mode 'dart-mode)
    (error "Only works with dart-mode."))
  (message (concat "Running tidy-dart on " (buffer-file-name)))
  (shell-command
   (mapconcat 'shell-quote-argument
              (list "/home/build/google3/ads/apps/video/tools/tidy_dart" (buffer-file-name)) " "))
  (revert-buffer nil t))

(provide 'google3-tidy-dart)
