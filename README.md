# About

This is kinda like `make`, for `bash`, but not even remotely close in
capability.

# Usage

See what you can do:

    $ cat nakefile
    default-task () {
        echo Running default task
    }

    deploy () {
        echo -n uploading to my-server...
        tar --create --bzip2 * \
            | ssh my-server "cd /htdocs;
                rm -rf ./*;
                tar --extract --bzip2;"
        echo done
    }

and,

    $ n -l
    default-task
    deploy

    $ n
    Running default task

    $ n deploy
    uploading to my-server...done

Also, task auto-completion is available for bash and zsh.

# Installation

Place the `n.sh` file somewhere accessible and *source* it in your
`.bashrc`/`.zshrc`.

    $ curl https://bitbucket.org/sharat87/n-nake/raw/tip/n.sh > ~/.n.sh
    $ echo '. ~/.n.sh' >> ~/.bashrc

`n` should be ready to use now.

# Contributions

Even as basic as `n` is currently today, it has proven to be very useful to me.
Any suggestions/ideas/feedback welcome. Please open an issue on bitbucket or
send a pull request, if the change is simple enough.

# License

[MIT License](http://mit.sharats.me)
