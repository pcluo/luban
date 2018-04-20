;; (require 'benchmark-init)
;; (add-hook 'after-init-hook 'benchmark-init/deactivate)

;; =================================================================================================
;; elpy config
;; =================================================================================================
;; (package-initialize)
(elpy-enable)

;; (setq python-shell-interpreter "Jupiter"
;;       python-shell-interpreter-args "console --simple-prompt")

;; (setq python-shell-completion-native-enable nil)
;; (setq python-shell-prompt-detect-failure-warning nil)


;; (remove-hook 'elpy-modules 'elpy-module-flymake)
(setq elpy-shell-cell-boundary-regexp
      "^\\(?:##.*\\|#\\s-*<.+>\\|#\\s-*\\(?:In\\|Out\\)\\[.*\\]:\\|#\\s-*%%.*\\)\\s-*$")
(setq elpy-shell-codecell-beginning-regexp
      "^\\(?:##.*\\|#\\s-*<.+>\\|#\\s-*\\(?:In\\|Out\\)\\[.*\\]:\\|#\\s-*%%.*\\)\\s-*$")
(setq elpy-rpc-backend "jedi")

(eval-after-load "elpy"
  '(cl-dolist (key '("C-c C-f"))
     (define-key elpy-mode-map (kbd key) nil)))

;; =================================================================================================
;; general stuff
;; =================================================================================================
(add-to-list 'default-frame-alist '(width  . 120))
(add-to-list 'default-frame-alist '(height . 60))
(when window-system (set-frame-position (selected-frame) 300 0))

(set-face-attribute 'region nil :background "#666")

                                        ; (setq whitespace-style (delete 'lines-tail whitespace-style))
                                        ; (setq whitespace-line-column 120)
;; (setq whitespace-global-modes '(not org-mode))

                                        ; (setq projectile-indexing-method 'native)
;; (setq projectile-indexing-method 'alien)
;; (setq projectile-indexing-method 'native)

(setq-default major-mode 'text-mode)
(require 'ess-site)
;; multiple cursor
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; byte-compile
(defun byte-compile-init-dir ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))

;; (defun remove-elc-on-save ()
;;   "If you're saving an elisp file, likely the .elc is no longer valid."
;;   (add-hook 'after-save-hook
;;             (lambda ()
;;               (if (file-exists-p (concat buffer-file-name "c"))
;;                   (delete-file (concat buffer-file-name "c"))))
;;             nil
;;             t))
;; (add-hook 'emacs-lisp-mode-hook 'remove-elc-on-save)

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

;; Unbind Pesky Sleep Button
(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])
;; Windows Style Undo
(global-set-key [(control z)] 'undo-tree-undo)
(global-set-key [(control shift z)] 'undo-tree-redo)
(add-hook 'undo-tree-mode-hook
          (lambda () (define-key undo-tree-map (kbd "C-/") 'comment-line)))


;; =================================================================================================
;; mac specific settings
;; =================================================================================================
(when (eq system-type 'darwin)
  (setq mac-control-modifier 'super)
  (setq mac-command-modifier 'control)
  (setq dired-use-ls-dired nil)
  (set-frame-font "Hack-14" nil t)
  (setq ispell-personal-dictionary "~/Dropbox/my_workspace/luban/config_stuff/dictionary/en-mac.pws")
)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "PYTHONPATH")
  (exec-path-from-shell-copy-env "MPLBACKEND"))

;; =================================================================================================
;; windows specific settings
;; =================================================================================================
(when (eq system-type 'windows-nt)
  (set-frame-font "Consolas-11" nil t)
  (add-to-list 'default-frame-alist '(font . "Consolas-11"))
  
  ;; (setq w32-pass-lwindow-to-system nil)
  ;; (setq w32-lwindow-modifier 'super) ; Left Windows key
  ;; (setq w32-pass-rwindow-to-system nil)
  ;; (setq w32-rwindow-modifier 'super) ; Right Windows key
  (setq w32-pass-apps-to-system nil)
  (setq w32-apps-modifier 'super) ; Menu/App key

  (setenv "PATH"
          (concat
           ;; adapt "C:\\tools\\cmder" if you changed cmder default dir
           "C:\\Users\\pcluo\\cmder\\vendor\\git-for-windows\\usr\\bin;"
           (getenv "PATH")))

  (setenv "PYTHONPATH" (getenv "PYTHONPATH"))
  (setenv "MPLBACKEND" (getenv "MPLBACKEND"))
  ;; (setq find-program "C:\\Program Files (x86)\\GnuWin32\\bin\\find.Axe")
  (setq w32-get-true-file-attributes nil)
  (setq w32-pipe-read-delay 0)
  (setq ispell-personal-dictionary "~\\Dropbox\\my_workspace\\luban\\config_stuff\\dictionary\\en.pws")
  (set-process-coding-system (get-buffer-process (elpy-rpc--get-rpc-buffer)) 'utf-8-dos 'utf-8-dos)
  )

;; =================================================================================================
;; set up org mode
;; =================================================================================================
;; (define-key org-mode-map "\M-q" 'toggle-truncate-lines)
(setq org-startup-truncated nil)
(add-hook 'org-mode-hook 'turn-on-flyspell)
(eval-after-load "org" '(require 'ox-md nil t))
(eval-after-load "org" '(require 'ox-odt nil t))

                                        ; (setq user-mail-address "cluoren@gmail.com")
                                        ; (setq  "Patrick Luo")

;; (when (eq system-type 'windows-nt) ;; windows specific settings
;;   (setq org-odt-styles-dir "c:\\Users\\pcluo\\emacs-25.3_1-x86_64\\share\\emacs\\25.3\\etc\\org\\")
;;   (setq org-odt-schema-dir "c:\\Users\\pcluo\\emacs-25.3_1-x86_64\\share\\emacs\\25.3\\etc\\schema\\")
;; )

;; =================================================================================================
;; misc
;; =================================================================================================

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
;; (defun rename-file-and-buffer (new-name)
;;   "Renames both current buffer and file it's visiting to NEW-NAME."
;;   (interactive "sNew name: ")
;;   (let ((name (buffer-name))
;;         (filename (buffer-file-name)))
;;     (if (not filename)
;;         (message "Buffer '%s' is not visiting a file!" name)
;;       (if (get-buffer new-name)
;;           (message "A buffer named '%s' already exists!" new-name)
;;         (progn
;;           (rename-file filename new-name 1)
;;           (rename-buffer new-name)
;;           (set-visited-file-name new-name)
;;           (set-buffer-modified-p nil))))))
