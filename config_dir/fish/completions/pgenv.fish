complete -c pgenv --exclusive

complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa use -d "Set and start the current PostgreSQL version"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa start -d "Start the current PostgreSQL server"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa stop -d "Stop the current PostgreSQL server"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa restart -d "Restart the current PostgreSQL server"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa status -d "Show the current PostgreSQL server status"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa switch -d "Set the current PostgreSQL version"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa clear -d "Stop and unset the current PostgreSQL version"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa build -d "Build a specific version of PostgreSQL"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa rebuild -d "Re-build a specific version of PostgreSQL"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa remove -d "Remove a specific version of PostgreSQL"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa version -d "Show the current PostgreSQL version"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa current -d "Same as 'version'"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa versions -d "List all PostgreSQL versions available to pgenv"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa help -d "Show this usage statement and command summary"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa available -d "Show which versions can be downloaded"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa check -d "Check all program dependencies"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa config -d "View, edit, delete the program configuration"
complete -c pgenv -n "test (__fish_number_of_cmd_args_wo_opts) = 1" -xa log -d "Inspects the log of the cluster, if exist."



function __pgenv_using_command
    set cmd (commandline -opc)

    if [ (count $cmd) -gt 1 ]
        for arg in $argv
            if [ $arg = $cmd[2] ]
                return 0
            end
        end
    end

    return 1
end

complete -c pgenv -n "__pgenv_using_command switch use remove rebuild" -xa "(pgenv versions | sed -E 's/^.**pgsql-(.*)\$/\1/')"
