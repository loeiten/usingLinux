# Using svn

svn can be handy, but in my opinion not as handy as git. On certain occasions
svn has the bad habit of messing up the database and checksum, and it looks
like the best solution is then to delete the local repository and checkout from
the start.

**NOTE**: Some repositories are possible to access from the browser. Just be
aware that a commit to the repository is done, it is sometimes necessary to
close and re-open the browser in order to see the changes.

**NOTE**: There exists "collection" of repositories, which you cannot check out
from, for example `https://svn.something.dk/` may be a collection which cannot
be checked out from, whereas `https://svn.something.dk/username` is a
repository which can be checked out from.

**NOTE**: svn works essentially differently than git. In order for svn to
understand what you are doing, you have to add `svn` in front of everything you
do. For example if `from.txt`, `mv from.txt to.rxt` will move the file around
on your file system, but svn will not catch this, and will usually complain that
the file is not found if you try to commit. In order for svn to understand, the
command will be `svn mv from.txt to.rxt`

## Setting up svn with vim
To change the editor, you can add the following to the `.bashrc` file

```
export SVN_EDITOR=vim
```

To change the svn diff, have a look at

http://blog.tplus1.com/blog/2007/08/29/how-to-use-vimdiff-as-the-subversion-diff-tool/

The difference between reversion 9 and 10 will can then be found by

```
svn diff -r 9:10 myfile.txt
```

## Checking out a repository
This will "download" the repository
1. Make the dir you would like to put the repository in
2. Checkout with `svn co <repository> <folder>`
   * If you want to check out to this folder, the `<folder>` will simply be `.`

Example
```
svn co https://svn.something.dk/user/cool-codes/ .
```

**NOTE**: The `<folder>` is sensitive with respect to spaces, meaning that a
folder named `my folder`, should be renamed to `my_folder` in order to use it
with svn.

## Daily use
After downloading from repository, the daily use of svn (at least in my case)
goes like this

```
svn up && svn ci -m "message"
```

where `svn up` is short for `svn update`, which update the repository, and
`svn ci` is short for `svn commit`, which commits the changes. `-m "message"`
is the commit message, and `&&` is the logical `and` operator

## Working directly with repositories
One can use the standard syntax

```
svn move <from repository> <to repository>
svn mkdir https://svn.something.dk/user/newFolder
```

It is also possible to import files directly into repositories
```
svn import folder https://svn.something.dk/user/folder
svn import file.txt https://svn.something.dk/user/folder/file.txt
```
