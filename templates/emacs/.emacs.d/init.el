;;For slime
;;(setq inferior-lisp-program "/usr/local/bin/clisp")
;;(add-to-list 'load-path "/Users/naoya/lispstudy/slime-2.14")
;;(require 'slime)
;;(slime-setup)

;; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'sudo-ext)

;;php-mode
(require 'php-mode)

(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

(setq diff-switches "-u")

(setq-default indent-tabs-mode nil)
(global-set-key "\C-h" 'delete-backward-char)
(setq scroll-conservatively 1)
(setq backup-inhibited t)
(setq auto-save-dafault nil)
(show-paren-mode t)

(defun my-scroll-down-command3 ()
  (interactive)
  (scroll-down 5))
(define-key global-map (kbd "\C-u") 'my-scroll-down-command3)

(defun my-scroll-up-command3 ()
  (interactive)
  (scroll-up 5))
(global-set-key "\C-o" 'my-scroll-up-command3)

(define-key global-map (kbd "C-c i") 'indent-region)
(define-key global-map (kbd "C-c C-i") 'hippie-expand)

;;(global-hl-line-mode) ;;現在行ハイライト
;;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(icomplete-mode 1)
(setq make-backup-files nil)
(global-linum-mode t)
(global-set-key [f9] 'linum-mode)
(set-face-attribute 'linum nil
                    :foreground "#800")
(global-set-key "\C-x\C-g" 'goto-line)
;; メニューバーを非表示
(menu-bar-mode -1)
;;; ウィンドウ内に収まらないときだけ括弧内も光らせる
(setq show-paren-style 'mixed)
;; バッファの移動
(global-set-key "\C-x\C-b" 'bs-show)
;; ファイル名補完
(iswitchb-mode 1)
(put 'upcase-region 'disabled nil)
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))
(global-set-key "\C-c\C-r" 'window-resizer)
(put 'set-goal-column 'disabled nil)

;;double space visualize
;;(defface my-face-r-1 '((t (:background "gray15"))) nil)
(defface my-face-b-1 '((t (:background "gray"))) nil) ; color of zenkaku-space
(defface my-face-b-2 '((t (:background "gray26"))) nil) ; color of tab
;;(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;(defvar my-face-r-1 'my-face-r-1)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
;;(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ;;("[ \t]+$" 0 my-face-u-1 append)
     ;;("[\r]*\n" 0 my-face-r-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
;; settings for text file
(add-hook 'text-mode-hook
          '(lambda ()
             (progn
               (font-lock-mode t)
               (font-lock-fontify-buffer))))

