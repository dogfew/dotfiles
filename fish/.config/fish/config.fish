export PATH="$HOME/.local/bin:$PATH"
if test -f /usr/local/bin/helix
    export EDITOR="/usr/local/bin/helix"
else if test -f /usr/local/bin/hx
    export EDITOR="/usr/local/bin/hx"
else if test -f /usr/bin/hx
    export EDITOR="/usr/bin/hx"
else if test -f /usr/bin/helix
    export EDITOR="/usr/bin/helix"
else if test -f ~/.local/bin/hx
    export EDITOR="~/.local/bin/hx"
end
if status is-interactive
    fish_vi_key_bindings
    # fish_helix_key_bindings
    bind \cd delete-char
    fish_config theme choose base16-default --color-theme=dark
    if command -v zoxide >/dev/null
        zoxide init fish --cmd=z | source
    end
    function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
        if test "$argv" = !!
            echo sudo $history[1]
            eval command sudo $history[1]
        else
            command sudo $argv
        end
    end
    function fish_prompt
        set -l last_status $status
        set -l stat
        set -l pwd
        if contains -- --final-rendering $argv
            set pwd (path basename $PWD)
        else
            set pwd (prompt_pwd)
            if test $last_status -ne 0
                set stat (set_color red)"[$last_status]"(set_color normal)
            end
        end

        string join '' -- (set_color green) $pwd (set_color cyan) $stat ' '
    end
end
