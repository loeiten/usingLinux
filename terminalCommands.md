# Terminal commands

The following work under the standard `bash` shell. The most convenient way to
open a terminal is through for example click on the icon representing the
shell, but note that text mode terminals are usually available.

* <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>F1</kbd> to <kbd>F7</kbd> - Text modes
* <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>F8</kbd> - Graphical mode

http://linux.org.mt/article/terminal

http://www.ee.surrey.ac.uk/Teaching/Unix/

* [The essentials](#the-essentials)
* [Display text](#display-text)
* [Redirecting output](#redirecting-output)
* [File commands](#file-commands)
* [Environmental variables](#environmental-variables)
* [Search commands](#search-commands)
* [Replace strings in multiple files](#replace-strings-in-multiple-files)
* [Keyboard shortcuts](#keyboard-shortcuts)
* [Processes](#processes)
* [Shebang line](#shebang-line)


## The essentials

Command          | Effect
-----------------|--------------
`cd ..`          | Change directory "up" on level
`cd `            | Change directory to home directory
`cd -`           | Change directory to previous directory
`cd my/path/`    | Change directory to `my/path/` residing in the current directory
`cd /usr/bin/`   | Change directory to `/usr/bin/` (the first `/` makes this an "absolute" address)
`pwd`            | Displays current directory
`ls`             | List files in current directory
`command --help` | Short manual for a command
`info command`   | Verbose manual for a command
`man command`    | Show the full manual
`./excutable`    | Execute the file called executable, residing in the current directory
`echo "test"`    | Will print `"test"` to the screen
`chmod +x file`  | Make `file` exacutable (`chmod` changes access permissions)


## Display text

### cat
`cat` can be used to
* Display text files on screen.
* Copy text files.
* Combine text files.
* Create new text files.

Examples:
* `cat filename` - Display text in terminal
* `cat file1 file2 > newcombinedfile` - Combine `file1` and `file2` to
  `newcombinded` (`>` is a general symbol used to direct the output)

http://www.cyberciti.biz/faq/howto-use-cat-command-in-unix-linux-shell-script/

### less
The `less` command enables you to scroll the content (press `q` to exit)


## Redirecting output
The `>` operator can redirect output. It can be used to print the output to a
file rather than to the screen. For example:

```
ls > myfile
```

will write the standard output `ls` to the file `myfile`.

* `>>` - append to a file
* `command > file 2>&1` - The `2>&1` will redirect both the standard output and
  the error output


## File commands
Command               | Effect
----------------------|-----------------------
`mkdir name`          | Makes new directory
`rmdir name`          | Removes (empty directories)
`mv name newname`     | Renames/moves a file
`mv name1 name2 dir`  | Move files
`file name`           | Displays type of file
`locate file`         | Locates a folder (faster than `find` due to write to a database, but not standard)
`rm -rf file`         | `-f` removes forcefully, `-r` removes recursively
`cp file1 file2`      | Copy `file1` to `file2`
`cp -r file1 file2`   | Copy `file1` to `file2` recursively (i.e. when copying directories)
`scp file1 file2`     | Secure copy `file1` to `file2` (usually used when copying over networks, for example if `file2` is `user@server:/path/`


One can compress (zip) a file with
```
tar -zcvf compressedName.tar.gz filesOrFolders
```
where

* `-z` - Compress archive using gzip program
* `-c` - Create archive
* `-v` - Verbose i.e display progress while creating archive
* `-f` - Archive File name
* Use `-x` to extract


## Environmental variables
Variables available in the terminal

Command                 | Effect
------------------------|-----------------------
`export myVar=5`        | Assign `5` to the variable `myVar`
`export myVar2=python`  | Assign `python` to the variable `myVar2`
`echo $myVar`           | Echoes the variable `myVar`
`$myVar2`               | Calls the command stored in `myVar2`
`$HOME`                 | Variable which stores the users home directory
`$SHELL`                | Variable which stores the shell
`$PATH`                 | Variable which stores where to search for commands (executables) like `ls`
`$PS1`                  | Tells what to display in prompt
`set`                   | Views all current environment variables

**NOTE**:
Aliasing can be used to redefine commands (this can be stored in `~/.bashrc` so
it doesn't need to be written every time. For example
```
alias ls="ls -a"
```
Sets `ls -a` to `ls`


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

**NOTE**: Double quotation marks can be used in the sed string

If one have to replace over several lines, one can use a combination of
`pcgrep` and `perl`

```
pcregrep -rlM --buffer-size=1000K "I am spanning\nseveral lines" . | perl -0777 -i -pe 'I am spanning\nseveral lines/Still spanning\nsmany lines/igs' $(xargs)
```

http://vasir.net/blog/ubuntu/replace_string_in_multiple_files


## Keyboard shortcuts
Stroke                                      | Effect
--------------------------------------------|-----------------------
<kbd>Ctrl</kbd>+<kbd>r</kbd> `text`          | Reverse search. Press <kbd>Ctrl</kbd>+<kbd>r</kbd> repeatedly to search backwards
<kbd>Ctrl</kbd>+<kbd>c</kbd>                 | Cancel
<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>x</kbd> | Cut
<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>c</kbd> | Copy
<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>v</kbd> | Paste


## Processes
Command                | Effect
-----------------------|-----------------------
`top`                  |  Monitoring processes by cpu usage, can also task manage from there
`ps aux`               |  Watch all processes
`kill <process id>`    |  Terminates process
`time`                 |  Gives how much time the program is using
`nice -n 1 <operation>`|  Setting the nice value. A high value means high priority. Example: `nice -n 1 python myScript.py`

http://www.cyberciti.biz/faq/show-all-running-processes-in-linux/


## Shebang line
If `#!` is written in the first line of a script, this line is called the
shebang line. This line tells the program loader which interpreter to use.
For example

```
#!/usr/bin/env bash
```

Tells the program loader to use bash which is found in the current environment
