Ironment
========

[![Build Status](https://travis-ci.org/badeball/ironment.svg)](https://travis-ci.org/badeball/ironment)
[![Code Climate](https://codeclimate.com/github/badeball/ironment/badges/gpa.svg)](https://codeclimate.com/github/badeball/ironment)

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

## Changelog

### 0.0.1

* Initial version. Contains basic support for wrapping commands and populating
  the environment by recursively reading the directory structure upwards and
  looking for .envrc files.
