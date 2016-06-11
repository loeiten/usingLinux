# Window management

* [Split screen bash](#split-screen-bash)
* [Invert colors](#invert-colors)
* [Hoover mouse](#hoover-mouse)
* [Maximize on double click](#maximize-on-double-click)
* [Add workspaces](#add-workspaces)
* [Compiz](#compiz)

## Split screen bash
Usually `screen` is installed. However, old versions lacked vertical splitting.
As an alternative, on could use `screen` on steroids, a.k.a `tmux`. For local
installation, see [tmuxLocalInstall.sh](shellScripts/tmuxLocalInstall.sh).

### Keybindings `tmux`

All keybindings start with <kbd>Ctrl</kbd> + <kbd>b</kbd>

Key           | Effect
--------------|-----------------------------------------------
<kbd>b</kbd>  | Change directory "up" on level
<kbd>%</kbd>  | Create new window in vertical pane
<kbd>"</kbd>  | Create new window in horizontal pane
<kbd>o</kbd>  | Next pane
<kbd>Up</kbd> | Move to pane above (works with all arrow-keys)
<kbd>c</kbd>  | (Create) new window
<kbd>,</kbd>  | Rename window
<kbd>n</kbd>  | Next pane
<kbd>p</kbd>  | Previous pane
<kbd>w</kbd>  | List windows
<kbd>[</kbd>  | Enables scroll, exit with <kbd>q</kbd>
<kbd>;</kbd>  | Enter `tmux` commands



## Invert colors
1. `sudo apt-get install xcalib`
2. Open `Keyboard Shortcuts`
3. Click on <kbd>Add</kbd>
4. Add a name
5. Enter `xcalib -i -a` in `Command`
6. Assign a shortcut, for example <kbd>Alt</kbd>+<kbd>n</kbd>

## Hover mouse
Open `Window Preferences` -> `Behaviour` -> `Select windows when the mouse moves
over them`

## Maximize on double click
Open `Window Preferences` -> `Behaviour` -> `Titlebar action: Double-click
perform` -> `Maximize`

## Add workspaces
For Linux Mint 17, you can right click on an empty place in the taskbar/menu bar
(the bar where `Menu` is placed). Click on `Add to panel`->`Workspace
switcher`. Right click on the `Workspace switcher`-> `Preferences`.

## Compiz
Compiz is generally enhancing the windows, and is usually installed by default.
Take care when playing around with it though, as you can seriously break your
the graphics by choosing the wrong options.
