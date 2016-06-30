# The terminal

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
