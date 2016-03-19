# pdf manipulation

* [pdftk](#pdftk)
* [Extracting metadata](#extracting-metadata)
* [Edit page numbering](#edit-page-numbering)
* [Making a pdf annotationable](#making-a-pdf-annotationable)

## pdftk
Useful tool to manipulate `pdf`s. For example, extracting page 22-36 from a
pdf, can be done by typing

```
pdftk A=input_file.pdf cat A22-36 output output_file.pdf
```

Splitting a pdf file into one file for each page can be obtained by

```
pdftk file.pdf burst
```

For more cool stuff to do with `pdftk`, check out
[this](https://www.pdflabs.com/docs/pdftk-cli-examples/)

## Extracting metadata

1. Create a info dictionary

   ```
   pdftk new.pdf cat output new_w_info.pdf
   ```

2. Get the metadata
   ```
   pdftk old.pdf dump_data > in.info
   ```

3. Edit the metadata

5. Add the metadata (with the bookmarks)
   ```
   pdftk new_w_info.pdf update_info in.info output all_works.pdf
   ```

## Edit page numbering
See the answers at

http://superuser.com/questions/232553/how-to-change-internal-page-numbers-in-the-meta-data-of-a-pdf

## Making a pdf annotationable
```
qpdf -decrypt test.pdf editable.pdf
```
On Windows, Adobe Pro can perform the same features under `tools` -> `permissions`.
**Note**: that this deletes the chapter bookmarks, and can convert some pages to `.png`.
