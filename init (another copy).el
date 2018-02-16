(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)



(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))


;;(require 'paren)
;;(setq show-paren-style 'parenthesis)
;;(show-paren-mode +1)


(show-paren-mode 1)
(setq show-paren-delay 0)
(defun lispy-parens ()
  "Setup parens display for lisp modes"
  (setq show-paren-delay 0)
  (setq show-paren-style 'parenthesis)
  (make-variable-buffer-local 'show-paren-mode)
  (show-paren-mode 1)
  (set-face-background 'show-paren-match-face (face-background 'default))
  (if (boundp 'font-lock-comment-face)
      (set-face-foreground 'show-paren-match-face 
  		   (face-foreground 'font-lock-comment-face))
    (set-face-foreground 'show-paren-match-face 
 		 (face-foreground 'default)))
  (set-face-attribute 'show-paren-match-face nil :weight 'extra-bold))

(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)



(defmacro after (mode &rest body)
  `(eval-after-load ,mode
     '(progn ,@body)))


;;autocomplete
;;(require 'auto-complete)
;;(auto-complete-mode)


;;set window title to full file name
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;;show line numbers
(global-linum-mode t)


;; this is optional
;;(eval-when-compile (require 'cl))


;;highlight line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#b0b7b7")


;;(load-theme 'solarized-dark t)


;;(add-hook 'after-make-frame-functions
;;          (lambda (frame)
;;            (let ((mode (if (display-graphic-p frame) 'light 'dark)))
;;              (set-frame-parameter frame 'background-mode mode)
;;              (set-terminal-parameter frame 'background-mode mode))
;;            (enable-theme 'solarized)))

(require 'ido)
(ido-mode t)


(ac-config-default)


;;(add-to-list 'load-path "~/.emacs.d/elisp/color-theme-6.6.0")
;;(require 'color-theme)
;;(eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (color-theme-hober)))


;;(add-to-list 'load-path "~/.emacs.d/elisp/emacs-color-theme-solarized")
;;(require 'color-theme-solarized)
;;(color-theme-solarized)

;;(add-hook 'after-make-frame-functions
;;          (lambda (frame)
;;            (let ((mode (if (display-graphic-p frame) 'light 'dark)))
;;              (set-frame-parameter frame 'background-mode mode)
;;              (set-terminal-parameter frame 'background-mode mode))
;;            (enable-theme 'solarized)))


(defun autopair-insert-opening ()
  (interactive)
  (when (autopair-pair-p)
    (setq autopair-action (list 'opening (autopair-find-pair) (point))))
  (autopair-fallback))


(autopair-global-mode t)


(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value
;;(defvaralias 'c-basic-offset 'tab-width)
;;(defvaralias 'cperl-indent-level 'tab-width)



;;neotree
(add-to-list 'load-path "~/.emacs.d/neotree/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;;(server-start)


;;drag-stuff-mode
(add-to-list 'load-path "~/.emacs.d/elpa/drag-stuff-20150717.532/")
(require 'drag-stuff)
(drag-stuff-mode t)
(drag-stuff-global-mode t)


;;(setq-default c-basic-offset 4 c-default-style "linux")
;;(setq-default tab-width 4 indent-tabs-mode t)
;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)


(add-hook 'python-mode 'run-python)
(add-hook 'python-mode-hook
       '(lambda () (load-file "~/.emacs.d/init_python.el")) t)

(add-hook 'html-mode-hook
       '(lambda () (load-file "~/.emacs.d/init_html.el")) t)

(add-hook 'pascal-mode-hook
       '(lambda () (load-file "~/.emacs.d/init_pascal.el")) t)

(add-hook 'java-mode-hook
       '(lambda () (load-file "~/.emacs.d/init_java.el")) t)

(add-hook 'c-mode-hook
       '(lambda () (load-file "~/.emacs.d/init_c.el")) t)


;;show battery level
(display-battery-mode 1)

;;display time
(display-time-mode 1)

;;emacs nav
;;(add-to-list 'load-path "~/.emacs.d/elisp/emacs-nav")
;;(require 'nav)
;;(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
;;(global-set-key [f7] 'nav-toggle)


;;set new line key-shortcut to make ne line
;;(setq next-line-add-newlines t)

;;Imenu
(global-set-key (kbd "M-i") 'ido-goto-symbol)

;;TAGS
(require 'etags)
(defun ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapc (lambda (x)
        (unless (integerp x)
          (push (prin1-to-string x t) tag-names)))
      tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))

(global-set-key [remap find-tag] 'ido-find-tag)
(global-set-key (kbd "C-.") 'ido-find-file-in-tag-files)


;;smartscan-mode
;;(package-install 'smartscan)
(smartscan-mode 1)


;;disable indent on new line
;;(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))


;;delete keys
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

(global-set-key "\C-j" 'newline)


;;ecb configure - emacs like ide
;;(add-to-list 'load-path "/home/ruci/.emacs.d/elisp/ecb/")
;;(require 'ecb)
;;(require 'ecb-autoloads)
;;(global-set-key (kbd "C-c C-n") 'ecb-activate)
;;(global-set-key (kbd "C-c C-g") 'ecb-deactivate)
;;(global-set-key (kbd "C-c C-d") 'ecb-goto-window-directories)
;;(global-set-key (kbd "C-c C-b") 'ecb-goto-window-sources)
;;(global-set-key (kbd "C-c C-w") 'ecb-goto-window-methods)
;;(global-set-key (kbd "C-c C-e") 'ecb-goto-window-edit-last)
;;(global-set-key (kbd "C-c C-r") 'ecb-goto-window-history)


;;(defun ecb-activated-in-selected-frame ()
;;"A hack to use ECB in multiple frames. It first deactivates ECB, then
;;activate it in current frame."
;;(interactive)
;;(let ((current-frame (selected-frame)))
;;	; The frame foucs change when activating or deactivating ECB is weird, so
;;	; activate current selected frame explicitly.
;;	(if (and (boundp 'ecb-minor-mode) (ecb-minor-mode))
;;		(ecb-deactivate)
;;	)
;;	(select-frame current-frame)
;;	(ecb-activate)
;;	)
;;)


;; CEDET
;;(global-ede-mode 1)
;;(require 'semantic/sb)
;;(semantic-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eclimd-executable nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
