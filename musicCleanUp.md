# Cleaning up your music library

* [Clean up non-music files](#clean-up-non-music-files)
* [Correct extensions](#correct-extensions)
* [Convert format](#convert-format)
* [Normalize the dB](#normalize-the-db)

## Clean up non-music files
1. Find all extension types

   ```
   find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
   ```

   http://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy
2. Check the extensions of unwanted files

   ```
   find . -name "*.bak" -type f
   ```
3. Delete unwanted files

   ```
   find . -name "*.bak" -type f -delete
   ```

## Correct extensions
1. Download [changeExtension.sh](shellScripts/changeExtension.sh)
2. `./changeExtension.sh MP3 mp3`
3. `./changeExtension.sh Mp3 mp3`
4. `./changeExtension.sh m4a mp4`


## Convert format
This can be done with [soundconverter](http://soundconverter.org/)


## Normalize the dB
This can be done with [audacity](http://www.audacityteam.org/)

See discussion on

http://askubuntu.com/questions/246242/how-to-normalize-sound-in-mp3-files

## Correct the tags
This can be done elegantly by [MusicBrainz Picard](https://picard.musicbrainz.org/)
