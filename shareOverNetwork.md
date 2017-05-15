This can be done over the `samba` protocol, and is a good option if your usb port messed up for some reason.

**NOTE**: Parts of this tutorial may be redundant

1. Start by making a shared folder called `sharing`

   ```
   mkdir /home/[username]/sharing
   chown [username]:[username] /home/[username]/sharing
   ```

   where `[username]` is the username used which you would like to share from.

2. Fill it with the files you would like to share.

3. Install samba

   ```
   sudo apt-get install openssh-server openssh-client caja-share samba smbmount
   sudo mkdir -p /var/lib/samba/usershares/
   ```

4. Open your favorite editor (`vim`)

   ```
   sudo vim /etc/samba/smb.conf 
   ``` 

   and append the following to the last line:

   ```
   [sharing]
      comment = Sharing Directory
      path = /home/[username]/sharing
      browseable = yes
      read only = yes
      guest ok = yes
   ```

5. Set username and password

   ```
   sudo smbpasswd -a [username]
   ``` 
   
   First enter you super user password, then chose a password for the shared files

6. Restart the samba service

   ``` 
   service nmbd restart
   service smbd restart
   ``` 
 
7. Find the ip address on the computer you would like to share from

   This can be found with for example `ifconfig` (it is the number next to `inet addr:`) 

To download content, open the computer you would like to download the content to, and type

```
smb://[serverIP]/sharing
```

in a **file**browser (on ubuntu you can click on `Connect to server`)


http://tutorialforlinux.com/2016/06/21/easy-file-sharing-with-smb-quickstart-on-linux-mint-18-sarah-lts/
