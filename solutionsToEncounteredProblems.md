# Solution to encountered problems

Title should say it all.

* [Resolve unmet dependencies](#resolve-unmet-dependencies)
* [Docking station linux mint](#docking-station-linux-mint)
* [Matlab fonts not working](#matlab-fonts-not-working)
* [Slow internet Ubuntu](#slow-internet-ubuntu)
* [Wireless internet setup Linux Mint](#wireless-internet-setup-linux-mint)

## Resolve unmet dependencies

http://askubuntu.com/questions/140246/how-do-i-resolve-unmet-dependencies

## Docking station linux mint

1. Type `xrandr` to find device the computer is running on.
   In this example `HDMI-2` is detected with a resolution on `1900x1200`
2. `sudo /etc/X11/xorg.conf`
3. Under "Section", add the following paragraph
   ```
   Section "Monitor"
       Identifier  "HDMI-2"
       Option      "PreferredMode" "1900x1200"
   EndSection
  ```

4. Reboot
5. Open "Monitors" (usually in favorites)
6. Disable the laptop monitor
7. Save as default

http://www.neowin.net/forum/topic/1173391-mdm-login-window-resolution-issue/

## Matlab fonts not working

If you Cannot use latex or change font size
```
sudo apt-get install xfonts-75dpi xfonts-100dpi
```

## Slow internet Ubuntu

https://help.ubuntu.com/community/WifiDocs/Driver/bcm43xx

## Wireless internet setup Linux Mint
### New solution

http://www.youtube.com/watch?v=DokYLNvO6Co

Connect to internet bcmwl-kernel-source
Device manager

### Old solution

http://community.linuxmint.com/tutorial/view/1115
