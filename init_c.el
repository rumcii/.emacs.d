(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value
;;(defvaralias 'c-basic-offset 'tab-width)
;;(defvaralias 'cperl-indent-level 'tab-width)

;; add template
(require 'tempo)

(setq c-new-buffer-template 
      '(
        "#include <stdio.h>\n"
        "#include <stdlib.h>\n"
        "\n"
        "int main(void){\n"
        "\n"
        "}\n"
        ))

(defun my-c-style ()
  "My editing style for .c files."
  (c-mode)
  (if (zerop (buffer-size))
      (tempo-template-c-skeleton)))

(setq auto-mode-alist
      (cons '("\\.c\\'" . my-c-style) auto-mode-alist))

(tempo-define-template "c-skeleton" c-new-buffer-template
               nil
               "Insert a skeleton for a .c document")
