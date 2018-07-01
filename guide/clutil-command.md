# `clutil` Command

`clutil` command is one which provides several utilities relevant to
software development in Cloe, such as installation of external modules.

## `CLOE_PATH` environment variable

`CLOE_PATH` environment variable specifies the directory where Cloe's modules
and commands are installed by `clutil` command.
It defaults to `$HOME/.cloe` but can be set to other paths where you have
proper permission.

## Subcommands

### `install`

This subcommand installs specified repositories into the language path and
make it available from other scripts.

```
clutil install https://github.com/cloe-lang/examples
```

### `update`

This subcommand updates all repositories and reinstalls commands inside them.

```
clutil update
```

### `clean`

This subcommand cleans up all subdirectories in `CLOE_PATH`.
Note that it removes even modified repositories in `$CLOE_PATH/src` which may
contain unpushed changes.

```
clutil clean
```
