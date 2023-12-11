#!/usr/bin/fish

abbr -a cat bat
abbr -a j z
abbr -a l "exa -ah"
abbr -a ll "exa -lah"
abbr -a ra ranger
abbr -a v nvim

abbr -a g git
abbr -a ga "git add"
abbr -a gb "git branch"
abbr -a gcam "git commit --all --message"
abbr -a gcm "git commit"
abbr -a gcmsg "git commit --message"
abbr -a gco "git checkout"
abbr -a gd "git diff"
abbr -a gp "git push"
abbr -a gs "git status"
abbr -a gsw "git switch"
abbr -a gloga "git log --all --graph --oneline --decorate"

set fish_greeting

zoxide init fish | source
