# Install conky

See the `conky` files are located in the
[dotfiles](https://github.com/loeiten/dotfiles) directory, and is needed in
order for conky to work.

1. **NOTE**: The following will replace your dotfiles. Old dotfiles will be
   saved to `dotfilesOld`.

   ```
   cd ~
   git clone https://github.com/loeiten/dotfiles.git
   cd dotfiles
   cd conky
   chmod +x *.sh
   cd ..
   python makeSymlinks
   sudo apt-get install lm-sensors
   ```

2. Reply yes to all when installing the sensors

   ```
   sudo sensors-detect
   ```
3. Install conky

   ```
   sudo apt-get install conky conky-all
   ```
4.  Open `startup applications`
5. Click on `Add`
6. Chose a `name` and a `comment`
7. Choose either a) or b)

   a) Add the command `conky -p 10`

   b) Add the command `$HOME/.conky/.conky-startup.sh`
