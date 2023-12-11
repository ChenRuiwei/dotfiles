abbr -a cat bat
abbr -a j z
abbr -a jo joshuto
abbr -a l "exa -ah"
abbr -a ll "exa -lah"
abbr -a ra ranger
abbr -a v nvim

abbr -a g git
abbr -a ga "git add"
abbr -a gb "git branch"
abbr -a gc "git commit -v"
abbr -a gca "git commit -va"
abbr -a gca! "git commit -va --amend"
abbr -a gcam "git commit -am"
abbr -a gcmsg "git commit -m"
abbr -a gco "git checkout"
abbr -a gd "git diff"
abbr -a gp "git push"
abbr -a gr "git remote"
abbr -a grv "git remote -v"
abbr -a gs "git status"
abbr -a gsw "git switch"
abbr -a gloga "git log --all --graph --oneline --decorate"

set fish_greeting

fish_add_path ~/bin/

set -gx PAGER less

{{#if (is_executable "starship")}}
starship init fish | source
{{/if}}

{{#if (is_executable "zoxide")}}
zoxide init fish | source
{{/if}}
