;; Initialize Package Manager
;; To add the pre-installed packages in ~/.emacs.d/elpa/ to your load-path
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Ensure required packages are installed without reaching out to network if already present
(defvar my/packages '(company csv-mode rainbow-identifiers))

(when (seq-some (lambda (pkg) (not (package-installed-p pkg))) my/packages)
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (unless (package-installed-p pkg)
      (package-install pkg))))

;; Disable async native compilation at runtime (prevents eln-cache activity)
(setq native-comp-async-report-warnings-errors nil)
(setq native-comp-jit-compilation nil)


;; Theme & Visuals
(set-terminal-parameter nil 'background-mode 'dark)
(load-theme 'deeper-blue t)
;; If you ever customize themes interactively, Emacs will append auto-generated lines to the bottom of the file. To avoid duplicate block warnings or override issues, move (custom-set-faces ...) after (load-theme 'deeper-blue t)
(custom-set-faces
 '(flyspell-incorrect ((t (:background "#4a1525" :foreground "#ff8888" :underline t))))
 '(hl-line ((t (:background "#292e42")))))
;; To see themes easily:
;; C-x 2, C-x o, M-x customize-themes RET.
(global-hl-line-mode 1)

;; Auto-complete (Company Mode)
(add-hook 'after-init-hook 'global-company-mode)
;; Fast auto-popup settings
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.1)


;; CSV Mode Configuration
(add-hook 'csv-mode-hook
          (lambda ()
            (rainbow-identifiers-mode 1)
            (csv-align-fields nil (point-min) (point-max))))


;; Basic editor settings
(setq make-backup-files nil)       ; Disable ~ backup files
(setq auto-save-default nil)        ; Disable #auto-save# files
;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(menu-bar-mode -1)                 ; Hide menu bar


;; Assert Truecolor and terminal type on startup (interactive only, to avoid headless errors)
(unless noninteractive
  (let ((colors (display-color-cells))
        (term-type (tty-type)))
    (unless (and (= colors 16777216)
                 (string= term-type "xterm-256color"))
      (error "Terminal check failed! tty-type: %s, colors: %s (expected 'xterm-256color' and 16777216)" 
             term-type colors))))


;; Custom Shortcuts
(defun my/force-kill-emacs ()
  "Exit Emacs immediately without saving modified buffers."
  (interactive)
  (let ((confirm-kill-emacs nil))
    (kill-emacs)))

(global-set-key (kbd "C-c q") #'my/force-kill-emacs)


;; Spell Checking (Hunspell)
(setq ispell-program-name "hunspell")
(setq ispell-dictionary "en_US")

(defun my/switch-dictionary ()
  "Toggle between en_US and es_ES dictionaries."
  (interactive)
  (let* ((current (or ispell-local-dictionary ispell-dictionary))
         (next (if (string= current "en_US") "es_ES" "en_US")))
    (ispell-change-dictionary next)
    (message "Dictionary switched to %s" next)))

(global-set-key (kbd "C-c s") #'my/switch-dictionary)

;; Associate text/markdown extensions and activate Flyspell
(add-to-list 'auto-mode-alist '("\\.md\\'" . text-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . text-mode))
;; Enable flyspell automatically in Markdown and Text buffers
(add-hook 'markdown-mode-hook #'flyspell-mode)
(add-hook 'text-mode-hook #'flyspell-mode)
;; Enable flyspell only for comments and strings in Python buffers
(add-hook 'python-mode-hook #'flyspell-prog-mode)

(custom-set-variables
 '(package-selected-packages nil))
