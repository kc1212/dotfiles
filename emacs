(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(tool-bar-mode -1)
(set-face-attribute 'default nil :height 140)

(require 'evil)
(evil-mode 1)

(require 'solarized)
(load-theme 'solarized-dark t)
