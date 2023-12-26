abbr -a cat bat
abbr -a j z
abbr -a jo joshuto
abbr -a l "exa -ah"
abbr -a ll "exa -lah"
abbr -a lg lazygit
abbr -a ra ranger
abbr -a v nvim
abbr -a m man
abbr -a tmux "TERM=xterm-256color tmux"

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
fish_add_path ~/.cargo/bin/

set -gx EDITOR nvim
set -gx PAGER less
set -gx MANPAGER nvimpager

function fish_user_key_bindings
    # for accepting autosuggestions in vi mode
    # https://github.com/fish-shell/fish-shell/issues/3541#issuecomment-260001906
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

starship init fish | source

zoxide init fish | source


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/crw/miniforge3/bin/conda
    eval /home/crw/miniforge3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<
