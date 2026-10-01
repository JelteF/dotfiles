status is-interactive; or return

# Activate the .venv of the project you cd into, so `python`, `pytest` etc.
# work without `uv run`. Searches upwards from the current directory like uv
# itself does, so subdirectories of a project get its venv too.
function __uv_venv_auto_activate --on-variable PWD
    set -l dir $PWD
    set -l venv
    while true
        if test -f $dir/.venv/bin/activate.fish
            set venv $dir/.venv
            break
        end
        test "$dir" = /; and break
        set dir (path dirname $dir)
    end

    test "$venv" = "$VIRTUAL_ENV"; and return

    # Only deactivate venvs this function activated. One activated by hand
    # stays active until you deactivate it yourself.
    if set -q __uv_venv_auto_activated
        if functions -q deactivate
            deactivate
        end
        set -e __uv_venv_auto_activated
    else if set -q VIRTUAL_ENV
        return
    end

    if test -n "$venv"
        source $venv/bin/activate.fish
        set -g __uv_venv_auto_activated 1
    end
end

# The handler only fires on a change, so run it once for shells that start
# inside a project (e.g. a new tmux pane).
__uv_venv_auto_activate
