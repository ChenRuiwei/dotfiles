abbr -a j z
{{#if (is_executable "eza")}}
abbr -a l "eza -ah"
abbr -a ll "eza -lah"
{{/if}}
abbr -a lg lazygit
abbr -a jj yazi
abbr -a v nvim
abbr -a m man
abbr -a tmux "TERM=xterm-256color tmux"

abbr -a mm micromamba
abbr -a mma "micromamba activate"
abbr -a mmd "micromamba deactivate"
abbr -a mmi "micromamba install"
abbr -a mms "micromamba search"

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
abbr -a gds "git diff --staged"
abbr -a gp "git push"
abbr -a gr "git remote"
abbr -a grv "git remote -v"
abbr -a gs "git status"
abbr -a gsw "git switch"
abbr -a gloga "git log --all --graph --oneline --decorate"

set fish_greeting

fish_add_path ~/bin/
fish_add_path ~/.cargo/bin/

export (envsubst < ~/.env)

function fish_user_key_bindings
    # for accepting autosuggestions in vi mode
    # https://github.com/fish-shell/fish-shell/issues/3541#issuecomment-260001906
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

fish_vi_key_bindings

set fish_cursor_default block
set fish_cursor_insert line

{{#if dotter.packages.starship}}
starship init fish | source
{{/if}}

zoxide init fish | source

{{#if (is_executable "mamba")}}
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
set -gx MAMBA_EXE (which mamba)
set -gx MAMBA_ROOT_PREFIX "~/.mamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
{{/if}}
