(require 'package)

; cask settings
(require 'cask "~/.cask/cask.el")


; Add package archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;(fset 'package-desc-vers 'package--ac-desc-version)

; Initialize
(package-initialize)

; initialize
(cask-initialize)


; c++ settings
(eval-after-load "yasnippet"
  '(progn
     (define-key yas-keymap (kdb "<tab>") nil)
     (yas-global-mode 1)))

(when (locate-library "company")
   (global-company-mode 1)
   (global-set-key (kbd "C-M-i") 'company-complete)
   ;; (setq company-idle-delay nil) ; 自動補完をしない
   (define-key company-active-map (kbd "C-n") 'company-select-next)
   (define-key company-active-map (kbd "C-p") 'company-select-previous)
   (define-key company-search-map (kbd "C-n") 'company-select-next)
   (define-key company-search-map (kbd "C-p") 'company-select-previous)
   (define-key company-active-map (kbd "<tab>") 'company-complete-selection))

(eval-after-load "irony"
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-hook 'c-mode-common-hook 'irony-mode)))

(when (require 'flycheck nil 'noerror)
  (custom-set-variables
   ;; shoe the error using pop-up
   '(flycheck-display-errors-function
     (lambda (errors)
       (let ((messages (mapcar #'flycheck-error-message errors)))
	 (popup-tip (mapconcat 'identity messages "\n")))))
   '(flycheck-display-errors-delay 0.5))
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
    (add-hook 'c-mode-common-hook 'flycheck-mode))

(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
              (flycheck-irony-setup))))
;; end c++ settings

; cmake setting
(require 'cmake-mode)
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

; ein emacs ipython notebook
(require 'ein)

; editor settings
(setq default-tab-width 4)

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)

(global-linum-mode)

; sh-script settings
(setq sh-basic-offset 2)
(setq sh-indentation 2)

; backup file setting
(setq backup-directory-alist '((".*" . "~/.emacs.d/ehist")))

