Ironment
========

[![Build Status](https://travis-ci.org/badeball/ironment.svg)](https://travis-ci.org/badeball/ironment)
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

### 0.0.3

* Correct an error in the gemspec.

### 0.0.2

* Adding a concept of trust. A file that has never been seen will no longer
  uncritically be used to populate the environment. Instead, the user will be
  prompted with its sha1sum and asked if they really want to trust it.

### 0.0.1

* Initial version. Contains basic support for wrapping commands and populating
  the environment by recursively reading the directory structure upwards and
  looking for .envrc files.
