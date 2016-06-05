(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; =============
;; irony-mode
;; =============
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

;; =============
;; company mode
;; =============
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
(define-key irony-mode-map [remap completion-at-point]
  'irony-completion-at-point-async)
(define-key irony-mode-map [remap complete-symbol]
  'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(eval-after-load 'company
'(add-to-list 'company-backends 'company-irony))
;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq irony-additional-clang-options '("-std=c++14"))
;; =============
;; flycheck-mode
;; =============
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; =============
;; eldoc-mode
;; =============
(add-hook 'irony-mode-hook 'irony-eldoc)
;; ==========================================
;; (optional) bind TAB for indent-or-complete
;; ==========================================
(defun irony--check-expansion ()
(save-excursion
  (if (looking-at "\\_>") t
    (backward-char 1)
    (if (looking-at "\\.") t
      (backward-char 1)
      (if (looking-at "->") t nil)))))
(defun irony--indent-or-complete ()
"Indent or Complete"
(interactive)
(cond ((and (not (use-region-p))
            (irony--check-expansion))
       (message "complete")
       (company-complete-common))
      (t
       (message "indent")
       (call-interactively 'c-indent-line-or-region))))
(defun irony-mode-keys ()
"Modify keymaps used by `irony-mode'."
(local-set-key (kbd "TAB") 'irony--indent-or-complete)
(local-set-key [tab] 'irony--indent-or-complete))
(add-hook 'c-mode-common-hook 'irony-mode-keys)

;;=========
;;ecb mode
;;=========
;; source on github
;; https://github.com/alexott/ecb
(add-to-list 'load-path "~/.emacs.d/sites/ecb")
(require 'ecb)
(semantic-mode 1)
(global-semantic-idle-scheduler-mode 1)
(setq ecb-layout-name "left9")

;; smartparens
(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; disable tool-bar
(tool-bar-mode -1)

;; line numbers
(global-linum-mode t)

;; backup files
(setq make-backup-files nil)
;; ==================
;; global key setings
;; ==================
(fset 'yes-or-no-p 'y-or-n-p)


(setq ecb-activated-layout 'nil)

;; toggling ecb layouts
;; TODO implement toggling
(defun switch-to-func-layout()
  (interactive)
  (if (not ecb-activated-layout) (ecb-activate))
  (setq ecb-activated-layout 'func)
  (ecb-layout-switch "left9"))

(defun switch-to-file-layout()
  (interactive)
  (if (not ecb-activated-layout) (ecb-activate))
  (ecb-layout-switch "left13"))

(defun switch-to-func-file-layout()
  (interactive)
  (if (not ecb-activated-layout) (ecb-activate))
  (ecb-layout-switch "leftright3"))


(global-set-key (kbd "<f5>")  'switch-to-func-layout)
(global-set-key (kbd "<f6>")  'switch-to-file-layout)
(global-set-key (kbd "<f7>")  'switch-to-func-file-layout)
(global-set-key (kbd "<f8>")  'ecb-deactivate)

(global-hl-line-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-tip-of-the-day nil)
 '(ecb-vc-enable-support t)
 '(ecb-windows-width 0.2)
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 131 :width normal)))))
