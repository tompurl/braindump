#!/bin/bash

set -e

emacs -Q --batch \
      -l /home/tom/src/braindump/config/bd-publish.el \
      /home/tom/src/braindump/index.org \
      --funcall org-publish-all \
      2>&1 | grep -vi "skipping\\|overview\\|tree-style"
