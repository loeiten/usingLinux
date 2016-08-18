# Install pyclewn

A very nice debugger for vim
http://pyclewn.sourceforge.net/

**NOTE**: With this the inferior tty will only work if vim is set up with the correct python locations

1. Build your [vim](vim.md)
2. `conda install pip`
3. `pip install --user pyclewn`
    **NOTE**:
    If you get errors that test does not exist, may have to copy the 'test'
    folder from `python-3.5.0/Lib` (from python.com) to `anaconda3/lib/python3.5`
4. `cd ~/Downloads`
5. `python -c "import clewn; clewn.get_vimball()"`
6. `vim -S pyclewn-2.3.vmb`

## Alternatives
The following have been tried, but without luck
- `CONQUE GDB` - Never opens the gdb [even in python 27]
- `VIMGBD` - Just didn't worked
- `GDBMGR` - Built and added gdbmgr.so to the library, but got message that no executable found
