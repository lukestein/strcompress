# strcompress
A Stata program that runs `compress` after converting string variables to strL. With an optional varlist, `strcompress` will only attempt strL conversion and compression on the named variables. Note that strL variables can *not* be used as key variables in merges.

To install, run
```stata
net install strcompress, from(https://raw.github.com/lukestein/strcompress/master/)
```

To install, run
```stata
net install strcompress, from(https://raw.github.com/lukestein/strcompress/master/)
```

To check if there are updates, run
```stata
ado update strcompress
```

Inspired by [this Twitter thread](https://twitter.com/lukestein/status/1222263793876492290)
