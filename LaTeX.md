# LaTeX

Tips and tricks when working with LaTeX

* [Source code in LaTeX](#source-code-in-latex)
* [Setup kile](#setup-kile)
* [texdiff](#texdiff)
* [Embed videos](#embed-videos)

## Source code in LaTeX
The `minted` package seems to do the job best (at the time of writing).
It uses the `pygment` package, which can also be used, but it can be a
bit more cumbersome to use.

https://www.sharelatex.com/learn/Code_Highlighting_with_minted

http://pygments.org/

## Setup kile
When going "outside the box", kile usually needs some modifications

### Making your own quickbuild
This is for example needed when you are building powerdot presentations

1. Open `kile`
2. Settings -> Configure Kile -> Tool -> Build -> LaTex -> Select: Modern
3. Settings -> Configure Kile -> Tool -> Build -> Quickbuil -> Select: LaTex+DVItoPS+PStoPDF+ViewPDF
4. Click on New...
5. Call it LaTex+DVItoPS+PStoPDF
6. Remove ViewPDF
7. Add shortcut = `Alt+1`

### Allow shell escape
Needed when one for example is converting `eps` to `pdf`

1. Open `kile`
2. Settings -> Configure Kile -> Tool -> Build -> [e.g. PDFLaTeX])
3. Add `-interaction=nonstopmode -shell-escape '%source'`

https://bugs.kde.org/show_bug.cgi?id=253789

## texdiff
`latexdiff` is a valuable tool when finding differences between two pdfs

https://www.ctan.org/pkg/latexdiff?lang=en

## Embed videos
In order to embed videos the `libx encoder` is needed

http://stackoverflow.com/questions/9764740/unknown-encoder-libx264

**NOTE**: `movie15` is obsolete, but working
http://pages.uoregon.edu/noeckel/PDFmovie.html

Alternatives are for example `media9`

The following works with linux players, but not on all Windows machines

```latex
 \begin{frame}
 \begin{figure}[ht]
 \includemovie[
   poster,
   text={\small(animation/output.mp4)}
 ]{6cm}{6cm}{animation/output.mp4}
 \end{figure}
 \end{frame}
```

### Convert your movie
```
avconv -i input.avi -c:v libx264 -g 30 -r 30 output.mp4
```

To get info about movie size (can do a ratio in order to get correct aspect),
type
```
ffprobe -i video.mpg
```

### Trouble shooting
Linux has (at least 03.17.2016), no readers which supports embedded videos.
There is a possibility to download adobe players, but this is with mixed
results

http://tex.stackexchange.com/questions/60160/includemedia-wont-play-video

ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.4.1/enu/

http://tex.stackexchange.com/questions/58104/beamer-media9-play-multiple-videos-at-once/58122#58122
