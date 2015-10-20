Ironment
========

[![Build Status](https://travis-ci.org/badeball/ironment.svg?branch=master)](https://travis-ci.org/badeball/ironment)
[![Code Climate](https://codeclimate.com/github/badeball/ironment/badges/gpa.svg)](https://codeclimate.com/github/badeball/ironment)
[![Test Coverage](https://codeclimate.com/github/badeball/ironment/badges/coverage.svg)](https://codeclimate.com/github/badeball/ironment/coverage)

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

## Installation

The utility can be installed using `gem`.

```
$ gem install ironment
```

It can be installed system-wide using the following options.

```
$ gem install --no-user-install -i "$(ruby -e'puts Gem.default_dir')" -n /usr/local/bin ironment
```

It is also packaged for Arch Linux.

```
$ yaourt -S ruby-ironment
```

## Changelog

### 1.0.1

* Update dependencies and unlock patch version numbers.

### 1.0.0

* SIGINT is now handled by the executable.

### 0.0.6

* Correct an issue where an unreadable, untrusted runcom would cause a stacktrace.
* Errors now contain the file subject (eg. *ironment: foo: No such file or directory*).

### 0.0.5

* `iron exec` now handles EACCES, ENOENT & EISDIR like `iron trust` and `iron untrust` does.
* `iron exec` now handles malformed runcom files.

### 0.0.4

* Correcting a bug under ruby-1.9.3.

### 0.0.3

* Correcting an error in the gemspec.

### 0.0.2

* Adding a concept of trust. A file that has never been seen will no longer
  uncritically be used to populate the environment. Instead, the user will be
  prompted with its sha1sum and asked if they really want to trust it.

### 0.0.1

* Initial version. Contains basic support for wrapping commands and populating
  the environment by recursively reading the directory structure upwards and
  looking for .envrc files.
