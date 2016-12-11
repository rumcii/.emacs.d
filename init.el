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
;;(set-face-background 'hl-line "#3e4446")


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
 '(ansi-color-names-vector ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(ansi-term-color-vector [unspecified "#000000" "#ff6c60" "#a8ff60" "#ffffb6" "#96cbfe" "#ff73fd" "#96cbfe" "#b5b3aa"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ecb-options-version "2.40")
 '(fci-rule-color "#eee8d5")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors (--map (solarized-color-blend it "#fdf6e3" 0.25) (quote ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors (quote (("#eee8d5" . 0) ("#B4C342" . 20) ("#69CABF" . 30) ("#69B7F0" . 50) ("#DEB542" . 60) ("#F2804F" . 70) ("#F771AC" . 85) ("#eee8d5" . 100))))
 '(hl-bg-colors (quote ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors (quote ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(inhibit-startup-screen t)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors (quote ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#e47200") (60 . "#e4ab00") (80 . "#b58900") (100 . "#e4e400") (120 . "#e4e400") (140 . "#e4e400") (160 . "#e4e400") (180 . "#859900") (200 . "#98e44c") (220 . "#72e472") (240 . "#4ce498") (260 . "#26e4be") (280 . "#2aa198") (300 . "#00e4e4") (320 . "#00e4e4") (340 . "#00e4e4") (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list (quote (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
