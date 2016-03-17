http://downloads.cc.dtu.dk/#
Comsol

NOTE: YOUR USERNAME MUST BE YOUR DTU INITIALS
http://www.techytalk.info/ubuntu-renaming-user-account/
- Need to delete ipython history 
  $HOME/.ipython/profile_default/history.sqlite
- Need to fix okular annotations (see $HOME/.kde/share/apps/okular/set_correct_user.sh)


Select version
Download the iso file

Follow the instructions on 
README_DTU_Campus.txt
i.e.
Choose <port_number>@<host_name> as license format when the installer asks for it, and provide the following information:
 Port number: 1718
 Host name  : license1.cc.dtu.dk
 Name       : <your name>
 Company    : Technical University of Denmark
NOTE: Install to a non-root folder

sudo ln -s /usr/local/comsol50/multiphysics/bin/comsol /usr/local/bin/comsol


For vpn connection
https://faq.oit.gatech.edu/content/how-do-i-install-cisco-anyconnect-client-linux
vpn.ait.dtu.dk
