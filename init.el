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


;;set window title to full file name
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;;show line numbers
(global-linum-mode t)


;; this is optional
;;(eval-when-compile (require 'cl))


;;highlight line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#b0b7b7")


(require 'ido)
(ido-mode t)


(ac-config-default)


(defun autopair-insert-opening ()
  (interactive)
  (when (autopair-pair-p)
    (setq autopair-action (list 'opening (autopair-find-pair) (point))))
  (autopair-fallback))


(autopair-global-mode t)


(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value


;;neotree
(add-to-list 'load-path "~/.emacs.d/neotree/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;;drag-stuff-mode
(add-to-list 'load-path "~/.emacs.d/elpa/drag-stuff-20150717.532/")
(require 'drag-stuff)
(drag-stuff-mode t)
(drag-stuff-global-mode t)


(add-hook 'python-mode 'run-python)
(add-hook 'python-mode-hook
       '(lambda () (load-file "~/.emacs.d/init_python.el")) t)

;; (add-hook 'html-mode-hook
;;        '(lambda () (load-file "~/.emacs.d/init_html.el")) t)

;; (add-hook 'pascal-mode-hook
;;        '(lambda () (load-file "~/.emacs.d/init_pascal.el")) t)

;; (add-hook 'java-mode-hook
;;        '(lambda () (load-file "~/.emacs.d/init_java.el")) t)

;; (add-hook 'c-mode-hook
;;        '(lambda () (load-file "~/.emacs.d/init_c.el")) t)

;;display time
(display-time-mode 1)


;;Imenu
(global-set-key (kbd "M-i") 'ido-goto-symbol)

(global-set-key [remap find-tag] 'ido-find-tag)
(global-set-key (kbd "C-.") 'ido-find-file-in-tag-files)


(smartscan-mode 1)

;;delete keys
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

(global-set-key "\C-j" 'newline)


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
