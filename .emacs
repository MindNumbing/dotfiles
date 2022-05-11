(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-etags-requires 1)
 '(custom-safe-themes
   (quote
    ("3629b62a41f2e5f84006ff14a2247e679745896b5eaa1d5bcfbc904a3441b0cd" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "1fc1fdf975c8c8c3767c29787a063eee50cbceef903644a0771fa66568ee8777" "c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "6df30cfb75df80e5808ac1557d5cc728746c8dbc9bc726de35b15180fa6e0ad9" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "025354235e98db5e7fd9c1a74622ff53ad31b7bde537d290ff68d85665213d85" "6fe6ab4abe97a4f13533e47ae59fbba7f2919583f9162b440dd06707b01f7794" "fb4bf07618eab33c89d72ddc238d3c30918a501cf7f086f2edf8f4edba9bd59f" default)))
 '(inhibit-startup-screen t)
 '(initial-scratch-message ";; Happy Hacking")
 '(package-selected-packages
   (quote
    (fill-column-indicator flycheck monokai-theme smooth-scrolling helm-gtags helm-projectile helm neotree projectile nyan-mode tabbar-ruler tabbar ac-c-headers ac-etags smart-mode-line-powerline-theme smart-mode-line stickyfunc-enhance google-c-style ggtags llvm-mode cython-mode markdown-mode web-mode go-mode rust-mode jedi)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(setq package-list '(jedi
		     rust-mode
		     go-mode
		     web-mode
		     markdown-mode
		     cython-mode
                     llvm-mode
		     ggtags
		     google-c-style
		     stickyfunc-enhance
		     smart-mode-line
                     smart-mode-line-powerline-theme
                     auto-complete
                     ac-etags
		     ac-c-headers
		     tabbar
		     tabbar-ruler
		     nyan-mode
		     projectile
                     neotree
		     helm
		     helm-projectile
		     helm-gtags
		     smooth-scrolling
                     monokai-theme
		     fill-column-indicator
                     flycheck))

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
        (package-install package)))

(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(global-visual-line-mode 1) ; 1 for on, 0 for off.
(menu-bar-mode -1)

(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-location 80)
(setq fci-rule-color "darkblue")
(fci-mode)

(when (eq system-type 'darwin)
  
  ;; Default Latin font (e.g. Consolas)
  (set-face-attribute 'default nil :family "Monaco")
  
  ;; default font size (point * 10)
  ;;
  ;; WARNING!  Depending on the default font,
  ;; if the size is not supported very well, the frame will be clipped
  ;; so that the beginning of the buffer may not be visible correctly. 
  (set-face-attribute 'default nil :height 125)
  )

; set command key to be meta instead of option
(if (system-is-mac)
   (setq ns-command-modifier 'meta))

;; auto reload disk changes
(global-auto-revert-mode t)
;; turn on line wrap
(setq-default truncate-lines 1)

(require 'smooth-scrolling)
(setq smooth-scroll-margin 5)

;; font lock, line and column numbers on modeline
(global-font-lock-mode 1)
(global-linum-mode 1)
(column-number-mode 1)

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(require 'helm)
(require 'helm-projectile)
(global-set-key (kbd "M-x") 'helm-M-x)
(require 'helm-gtags)

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'neotree-projectile-action)
(helm-projectile-on)

(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(semantic-mode 1)
(require 'stickyfunc-enhance)

;; (require 'neotree)
;; (with-eval-after-load 'neotree
;;   (add-hook 'neotree-mode-hook 
;;             (lambda () (with-current-buffer " *NeoTree*"
;;                          (setq-local linum-mode nil)))))
;; (global-set-key [f8] 'neotree-toggle)
;; (neotree-toggle)
;; (setq neo-theme 'ascii)
;; (custom-set-faces
;;  '(neo-banner-face ((t . (:inherit shadow))) t)
;;  '(neo-header-face ((t . (:inherit shadow))) t)
;;  '(neo-root-dir-face ((t . (:inherit link-visited :underline nil))) t)
;;  '(neo-dir-link-face ((t . (:inherit dired-directory))) t)
;;  '(neo-file-link-face ((t . (:inherit default))) t)
;;  '(neo-button-face ((t . (:inherit dired-directory))) t)
;;  '(neo-expand-btn-face ((t . (:inherit button))) t))

;; python packages
;; $ sudo pip install jedi epc

(transient-mark-mode 1) ; highlight text selection
(delete-selection-mode 1) ; delete seleted text when typing

;; highlight parens expression
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; stop creating those backup~ files
(setq make-backup-files nil)

;; stop creating auto-save files #
(setq auto-save-default nil)

;; make electric-pair-mode work on more brackets
(electric-pair-mode 0)
(setq electric-pair-pairs '((?\" . ?\")
                            (?\{ . ?\})))

;; spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; tabbar ruler
(setq tabbar-ruler-global-tabbar t)
(require 'cl)
(require 'tabbar-ruler)

;; modeline
(setq sml/no-confirm-load-theme t)
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'light-powerline)
;; (nyan-mode)
;; (nyan-start-animation)

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-20150521.2257/")
(load-theme 'monokai)

(setq-default cursor-type 'hollow)
(set-cursor-color "red")
(cua-mode 1)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20140824.1658/dict/")
(setq-default ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
(add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'objc-mode)

(require 'ac-c-headers)
(add-hook 'c-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-c-headers)
            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))
(add-hook 'c++-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-c-headers)
            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))


(eval-after-load "etags"
  '(progn
     (ac-etags-setup)))
(defun my/c-mode-common-hook ()
  (add-to-list 'ac-sources 'ac-source-etags))
(add-hook 'c-mode-common-hook 'my/c-mode-common-hook)
(add-hook 'c++-mode-common-hook 'my/c-mode-common-hook)

;; python jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; (defun flycheck-python-setup ()
;;   (flycheck-mode))
;; (add-hook 'python-mode-hook #'flycheck-python-setup)

;; My shortcut for "go to line"
(global-set-key (kbd "C-x g") 'goto-line)

;; Load python-mode for scons files
(setq auto-mode-alist (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("SConscript" . python-mode) auto-mode-alist))

;; .gpy is javascript
(setq auto-mode-alist (cons '("*.gyp" . javascript-mode) auto-mode-alist))

;; c/c++ mode style
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(setq-default c-basic-offset 4 c-default-style "linux")
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; web-mode on html files
(setq auto-mode-alist (append ' (("\\.html?\\'" . web-mode)) auto-mode-alist))

;; Mardown mode on .md files
(setq auto-mode-alist (append '(("\\.md\\'" . markdown-mode)) auto-mode-alist))

;; Markdown hook to auto-save more
(add-hook 'markdown-mode-hook
	  (lambda ()
	    (when buffer-file-name
	      (add-hook 'after-save-hook
			'check-parens
			nil t))))

;; high light current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#330")

;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;;; Unbind the stupid minimize that I always hit.
(global-unset-key "\C-z")

;; bell can go fuck
(setq ring-bell-function 'ignore)

;; line number mode
(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)

     (defun linum-format-func (line)
       (let ((w (length
                 (number-to-string (count-lines (point-min) (point-max))))))
         (concat
          (propertize (make-string (- w (length (number-to-string line))) ?0)
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum))))
     
     (setq linum-format 'linum-format-func)))
(setq linum-format "%3d \u2502")

(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matches for REGEXP in region.                    
Non-interactive arguments are Begin End Regexp"
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
                  (re-search-forward regexp end t))
        (if (= opoint (point))
            (forward-char 1)
          (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(setq indent-tabs-mode nil)

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
                    (set-buffer-modified-p nil))))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
