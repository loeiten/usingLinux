# Search and replace

The following work under the standard `bash` shell.

* [Search commands](#search-commands)
* [Replace strings in multiple files](#replace-strings-in-multiple-files)

## Search commands
Knowing where to find stuff makes things so much easier. Here is a few examples
on how one can search for stuff on linux.

* [Finding files and folders](#finding-files-and-folders)
* [Search for text in files](#search-for-text-in-files)
* [Combined search](#combined-search)
* [Search within pdf files](#search-within-pdf-files)

Once you get a hang of this, I highly encourage you to have a look at `regex`
when one get a hang of this. Although learning `regex` seem daunting at first,
the power can not be emphasized enough. See for example:

http://www.tutorialspoint.com/python/python_reg_expressions.htm

which shows how `regex` can be used with python.

For now, it suffice to know the `*` wild card in regex, which matches
everything. Example:

* `*.txt` will match everything which ends with `.txt`, for example `foo.txt`
  and `bar.txt`
* `*txt*` will give a match for `foo.txt`, `bar.txt`, `txt.log`, `mytxt.log`,
  etc.

### Finding files and folders
Use `find` to search for files and folder recursively

Example:
```
find [in path] -iname "*[string]*" ! -iname "*[exclude string]*"
```

Where:
* `-iname` means case insensitive
* `!` will exclude
* If `[in path]` is set to `.`, the search will start in the current directory

`find` can be used to for example delete annoying temporary files

```
find ~ -type f \( -name '*.swp' -o -name '*~' -o \) -delete
```

Where:
* `~` - home folder
* `-type f` - test that the file is an actual file
* `\(...\)` - grouping
* `-name '...'` - search for files matching whatever is inside `''`
* `'*.swp'` - files ending with `.swp`
* `'*~'` - files ending with `~`
* `-o` - logical `or`
* `-delete` - delete results that matches

### Search for text in files
`grep` finds a literal string inside a file.

Basic example:

```
grep "literal_string" filename
```

Advanced example

```
grep -nrI --exclude-dir={"examples","tools"} "ixseps1" *
```

Where

* `-n` - line number
* `-r` - recursively
* `-I` - ignore binaries
* `{}` -  array
* `*` - Wild card

`grep` excluding a pattern

```
grep -nrI "boutdata" * | grep -Iv "boutdata\."
```

http://www.thegeekstuff.com/2009/03/15-practical-unix-grep-command-examples/
http://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/

### Combined search
`grep` and `find` can be combined. Either one can

```
find . -iname "*.ipynb" | xargs grep -nrI "collect"
```

or

```
find . -iname "*.ipynb" -exec grep -nrI "collect" {} \+
```

http://unix.stackexchange.com/questions/20262/how-do-i-pass-a-list-of-files-to-grep


### Search within pdf files
`pdfgrep` can search through pdf's

```
pdfgrep -R 'Galerkin' .
```

http://stackoverflow.com/questions/4643438/how-to-search-contents-of-multiple-pdf-files


## Replace strings in multiple files
This can be very handy when used correctly
```
grep -rl "matchstring" somedir/ | xargs sed -i 's/string1/string2/g'
```

### Special characters
Assuimg we would like to change `abspath('./../')` to `abspath('./../../')`, we could write

```
grep -rl "abspath('./../')" . | xargs sed -i "s/abspath('.\/..\/')/abspath('.\/..\/..\/')/g"
```

### Change over several lines
If one have to replace over several lines, one can use a combination of
`pcgrep` and `perl`

```
pcregrep -rlM --buffer-size=1000K "I am spanning\nseveral lines" . | perl -0777 -i -pe 'I am spanning\nseveral lines/Still spanning\nsmany lines/igs' $(xargs)
```

http://vasir.net/blog/ubuntu/replace_string_in_multiple_files
