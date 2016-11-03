#!/usr/bin/env python

import os
import argparse

def changeSubstringInFolderThree(changeFrom="", changeTo=""):
    """
    Walks through the folder three and changes substrings in
    foldernames.

    Parameters
    ----------
    changeFrom : str
        Old substring
    changeTo : str
        New substring
    """
    # Appendable number of hits
    hits = []

    # Traverse root directory, and list directories as dirs and files as files
    for root, _, _ in os.walk("."):

        # Skip current folder
        if root == ".":
            continue

        # Get last part of folder three
        endOfThree = os.path.basename(root)
        if changeFrom in endOfThree:
            # Appent to hits
            hits.append(root)

    # Sort hits after decreasing occurence of folder separation
    pathSep = os.path.sep
    hits.sort(key=lambda x: x.count(pathSep), reverse = True)
    for fromPath in hits:
        toPath = fromPath.replace(changeFrom, changeTo)
        print("Renaming {} -> {}".format(fromPath, toPath))
        os.rename(fromPath, toPath)


if __name__ == "__main__":
    # Arg parsing
    parser = argparse.ArgumentParser(\
        description=(("Walks through the folder three and changes"
                      "substrings in foldernames.")))

    parser.add_argument("-f", "--changeFrom", default="", type=str,\
                        help="Old substring")

    parser.add_argument("-t", "--changeTo", default="", type=str,\
                        help="New substring")

    args = parser.parse_args()

    changeSubstringInFolderThree(args.changeFrom, args.changeTo)
