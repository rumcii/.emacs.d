(add-to-list 'load-path "~/.emacs.d/elisp/emacs-eclim")
(require 'eclim)
(global-eclim-mode)

;; set eclipse location
(custom-set-variables
  '(eclim-eclipse-dirs '("/opt/eclipse"))
  '(eclim-executable "/opt/eclipse"))

;; display compilation error messages
(custom-set-variables
  '(eclim-eclipse-dirs '("/opt/eclipse"))
  '(eclim-executable "/opt/eclipse/eclim"))

;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

;; integrate with company mode to provide popup dialogs
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)

(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value

;; add template
(require 'tempo)

(setq c-new-buffer-template 
      '(
        "public class temp {\n"
            "\tpublic static void main(String[] args) {\n"
	    "\n"
	    "\t}\n"
        "}\n"
        ))

(defun my-c-style ()
  "My editing style for .c files."
  (java-mode)
  (if (zerop (buffer-size))
      (tempo-template-java-skeleton)))

(setq auto-mode-alist
      (cons '("\\.java\\'" . my-c-style) auto-mode-alist))

(tempo-define-template "java-skeleton" c-new-buffer-template
               nil
               "Insert a skeleton for a .c document")
