# Install comsol on DTU

**NOTE**: Your username must be your dtu initials

If you need to change, this link tells you how to do it
http://www.techytalk.info/ubuntu-renaming-user-account/
- You need to delete ipython history `$HOME/.ipython/profile_default/history.sqlite`
- Need to rename okular annotations located in `$HOME/.kde/share/apps/okular/`

1. Go to http://downloads.cc.dtu.dk/#Comsol
2.  Select version
3. Download the iso file
4. Follow the instructions on `README_DTU_Campus.txt`, that is

   ```
   Choose <port_number>@<host_name> as license format when the installer asks for it, and provide the following information:
    Port number: 1718
    Host name  : license1.cc.dtu.dk
    Name       : <your name>
    Company    : Technical University of Denmark
   NOTE: Install to a non-root folder
   ```
5. sudo ln -s /usr/local/comsol50/multiphysics/bin/comsol /usr/local/bin/comsol

This can be accessed from the outside through a vpn connection.
