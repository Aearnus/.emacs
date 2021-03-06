;;(kill-emacs)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; INSTALL ALL MY PACKAGES
;; (package-refresh-contents)
;; (mapc 'package-install '(all-the-icons-dired
;;			 all-the-icons
;;			 intero
;;			 haskell-mode
;;			 memoize
;;			 neotree
;;			 nim-mode
;;			 flycheck-nimsuggest
;			 flycheck
;			 dash
;			 commenter
;			 epc
;			 ctable
;			 concurrent
;			 deferred
;			 northcode-theme
;			 pkg-info
;			 epl
;			 powerline
;			 smooth-scroll
;			 yaml-mode
;			 slime
;			 bar-cursor
;			 markdown-mode))
;; END MY PACKAGES

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(wheatgrass))
 '(custom-safe-themes
   '("2642a1b7f53b9bb34c7f1e032d2098c852811ec2881eec2dc8cc07be004e45a0" "10a31b6c251640d04b2fa74bd2c05aaaee915cbca6501bcc82820cdc177f5a93" "565aa482e486e2bdb9c3cf5bfb14d1a07c4a42cfc0dc9d6a14069e53b6435b56" default))
 '(inhibit-startup-screen t)
 '(mouse-wheel-progressive-speed nil)
 '(package-selected-packages
   '(love-minor-mode j-mode atom-dark-theme markdown-mode sublimity slime epl pkg-info deferred concurrent ctable epc commenter dash flycheck flycheck-nimsuggest neotree memoize package-install smooth-scroll intero lsp-haskell yaml-mode haskell-mode northcode-theme klere-theme powerline all-the-icons-dired all-the-icons dired-sidebar nim-mode))
 '(smooth-scroll/hscroll-step-size 1)
 '(smooth-scroll/vscroll-step-size 1)
 '(tab-stop-list '(4))
 '(tab-width 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-banner-face ((t (:foreground "lightblue" :weight bold :family "Ubuntu"))))
 '(neo-button-face ((t (:underline nil :family "Ubuntu"))))
 '(neo-dir-link-face ((t (:foreground "DeepSkyBlue" :family "Ubuntu"))))
 '(neo-expand-btn-face ((t (:foreground "SkyBlue" :family "Ubuntu"))))
 '(neo-file-link-face ((t (:foreground "White" :family "Ubuntu"))))
 '(neo-header-face ((t (:foreground "White" :family "Ubuntu"))))
 '(neo-root-dir-face ((t (:foreground "lightblue" :weight bold :family "Ubuntu"))))
 '(neo-vc-added-face ((t (:foreground "LightGreen" :family "Ubuntu"))))
 '(neo-vc-conflict-face ((t (:foreground "Red1" :family "Ubuntu"))))
 '(neo-vc-default-face ((t (:foreground "White" :family "Ubuntu"))))
 '(neo-vc-edited-face ((t (:foreground "Magenta" :family "Ubuntu"))))
 '(neo-vc-ignored-face ((t (:foreground "DarkGrey" :family "Ubuntu"))))
 '(neo-vc-missing-face ((t (:foreground "Red1" :family "Ubuntu"))))
 '(neo-vc-needs-merge-face ((t (:foreground "Red1" :family "Ubuntu"))))
 '(neo-vc-needs-update-face ((t (:underline t :family "Ubuntu"))))
 '(neo-vc-removed-face ((t (:strike-through t :family "Ubuntu"))))
 '(neo-vc-unlocked-changes-face ((t (:background "Blue" :foreground "Red" :family "Ubuntu"))))
 '(neo-vc-unregistered-face ((t (:family "Ubuntu"))) t)
 '(neo-vc-up-to-date-face ((t (:foreground "LightGray" :family "Ubuntu"))))
 '(neo-vc-user-face ((t (:foreground "Red" :slant italic :family "Ubuntu")))))

;; BEGIN MY CUSTOM CONFIG

;;(add-to-list 'load-path "~/packages/charm-mode/")
;;(require 'charm-mode)

;;(defun hello-world () (print "Hello from ELisp from Lua!"))

(menu-bar-mode 1)

(bar-cursor-mode 1)

(show-paren-mode 1)

(setq default-tab-width 4)

;;(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;;(add-hook 'haskell-mode-hook 'intero-mode)
;;(neotree)
(powerline-center-theme)

;; CUSTOM KEYBINDINGS

;; https://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key (kbd "C-S-d") 'duplicate-current-line-or-region)

(global-set-key (kbd "<M-up>") (lambda () (interactive)
				 (transpose-lines 1)
				 (previous-line 2)
				 (funcall indent-line-function)))

(global-set-key (kbd "<M-down>") (lambda () (interactive)
				   (next-line 1)
				   (transpose-lines 1)
				   (previous-line 1)
				   (funcall indent-line-function)))


(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(global-set-key (kbd "C-c r")  'rename-file-and-buffer)
