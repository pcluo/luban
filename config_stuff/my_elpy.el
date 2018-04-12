(package-initialize)
(elpy-enable)

(setq python-shell-interpreter "jupyter"
       python-shell-interpreter-args "console --simple-prompt")

 (setq python-shell-completion-native-enable nil)
 (setq python-shell-prompt-detect-failure-warning nil)

 (add-to-list 'default-frame-alist '(width  . 120))
 (add-to-list 'default-frame-alist '(height . 60))

(when window-system (set-frame-position (selected-frame) 300 0))
