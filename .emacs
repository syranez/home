(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
        "http://marmalade-repo.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elpa")
(require 'evil)
(evil-mode 1)
