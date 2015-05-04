Ironment
========

Ironment is a simple command line utility for populating the environment of a
command by reading particular environment files and then exec-ing. Such
environment files may look like the following.

```
# ./.envrc
FOO=bar
```

Any command wrapped with `iron` will see the environment variables.

```
$ iron env
FOO=bar
```
