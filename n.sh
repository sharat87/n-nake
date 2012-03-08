#!/bin/bash

n () {

    # Load the given task from first argument, or the default-task
    task="default-task"
    if [[ ! -z "$1" ]]; then
        task=$1
        shift
    fi

    # Find the project directory.
    project_dir="$PWD"
    while [[ ! -f "$project_dir/nakefile" && ! -z "$project_dir" ]]; do
        project_dir="${project_dir%/*}"
    done

    cd "$project_dir"

    if [[ ! -f nakefile ]]; then
        echo nakefile not found >&2
        return 1
    fi

    if [[ $task == -l ]]; then
        # Grep for functions in the nakefile
        grep '^[-a-zA-Z!?]\+\s\+()\s\+{$\|^function\s\+[-a-zA-Z!?]\+\s\+\(()\s\+\)\?{$' nakefile \
            | sed -e 's/^function\s\+//' -e 's/\(\s\+()\)\?\s\+{$//' \
            | sort
    else
        source nakefile
        "$task" "$@"
    fi
}

_n_bash () {
    COMPREPLY=( $(compgen -W "$(n -l)" -- "${COMP_WORDS[COMP_CWORD]}") )
}
complete -F _n_bash n 2> /dev/null

_n_zsh () {
    compadd $(n -l)
}
compdef _n_zsh n 2> /dev/null
