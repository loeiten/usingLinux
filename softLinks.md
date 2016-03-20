# Soft links

Soft links are rather easy to use in linux, and most programs recognizes them.
A soft link, or symbolic link is nothing but a pointer to a file

## Absolute links
Absolute links can be made by either

a) Right clicking on a file and selecting `Make link`
b) `ln -s path/to/link/from path/to/symbolic/link`

## Relative link
An absolute link can be made absolute by using `symlinks`.
To make links in a directory relative, type

```
symlinks -cr path/to/directory
```

# Hard links
It is also possible to make hard links.
A hard link isn't a pointer to a file, it's a directory entry (a file) pointing
to the same inode.

http://askubuntu.com/questions/108771/what-is-the-difference-between-a-hard-link-and-a-symbolic-link

```
ln path/to/source path/to/link
```

http://www.cyberciti.biz/faq/creating-hard-links-with-ln-command/
