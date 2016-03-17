# Installation of TORQUE on home computer

**NOTE**: Consider if this is really necessary, as there can be a lot of hassle
to deal with the computer when TORQUE is installed.

**NOTE**: Per 2015.05.19 jess is running TORQUE 4.1.7 (qstat --version)

The manual and installation files can be found on
http://www.adaptivecomputing.com/support/download-center/torque-download/

1. First install libcrul4-openssl-dev
2. Configuration

   ```
   cd ~/Downloads
   tar -zxvf torque-4.1.7.tar.gz
   cd torque-4.1.7/
   sudo su
   echo '/usr/local/lib' > /etc/ld.so.conf.d/torque.conf
   ldconfig
   ./configure
   make
   make install
   ```
3. Check that `/usr/local/bin/` and `/usr/local/sbin/` is in the `PATH`

   ```
   echo $PATH
   ```
4. Make and install the packages

   ```
   make packages
   # Exit the super user
   exit
   cd ~
   mkdir -p PBS_shared_storage/tmp
   cp Downloads/torque-4.1.7/torque-package-mom-linux-x86_64.sh ~/PBS_shared_storage/tmp/
   cp Downloads/torque-4.1.7/torque-package-clients-linux-x86_64.sh ~/PBS_shared_storage/tmp/
   sudo PBS_shared_storage/tmp/torque-package-mom-linux-x86_64.sh --install
   sudo PBS_shared_storage/tmp/torque-package-clients-linux-x86_64.sh --install
   cd Downloads/torque-4.1.7/
   sudo cp contrib/init.d/debian.pbs_mom /etc/init.d/pbs_mom
   sudo update-rc.d pbs_mom defaults
   # Stop the pbs server
   killall pbs_server
   ```
5. The next step in the manual didn't work for me, therefore changed to this manual
   http://willworkforscience.blogspot.dk/2012/01/quick-and-dirty-guide-for-parallelizing.html
6. Check if this gives an error (usually does on debian systems)

   ```
   host $HOSTNAME
   ```
   * If it does, then we must edit the /ect/hosts file in order for the system
     to see itself
     * Check your ip

       ```
       /sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'
       ```
    * Edit the host through `sudo vim /ect/hosts`. When done, it should look
      like this

      ```
      #  127.0.0.1 localhost
      #  #127.0.1.1 <computername>
      #  10.54.4.137 <computername>
      ```
7. Continue with

   ```
   sudo echo $HOSTNAME > /etc/torque/server_name
   sudo echo $HOSTNAME > /var/spool/torque/server_name
   sudo pbs_server -t create
   sudo echo $HOSTNAME np=`grep proc /proc/cpuinfo | wc -l` > /var/spool/torque/server_priv/nodes
   # If qterm fails, you probably have a problem with your /etc/hosts file
   sudo qterm
   sudo pbs_server
   sudo pbs_mom
   ```
8. Check if running

   ```
   pbsnodes -a
   sudo momctl -d 0 -h $HOSTNAME
   pbsnodes -a
   ```
9. Setup the queue

   ```
   sudo qmgr -c 'create queue batch'
   sudo qmgr -c 'set queue batch queue_type = Execution'
   sudo qmgr -c 'set queue batch resources_default.nodes = 1'
   sudo qmgr -c 'set queue batch resources_default.walltime = 01:00:00'
   sudo qmgr -c 'set queue batch enabled = True'
   sudo qmgr -c 'set queue batch started = True'
   sudo qmgr -c 'set server default_queue = batch'
   sudo qmgr -c 'set server scheduling = True'
   ```
10. Start the scheduler

    ```
    sudo pbs_sched
    ```
11. See if `_mom _server` and `_sched` is running

    ```
    ps -e | grep pbs
    ```
12. Check that this is empty

    ```
    qstat
    ```
13. Test

    ```
    echo "sleep 20" | qsub
    ```
14. Check that it worked

    ```
    qstat
    ```

## Troubleshooting
From http://chenmingzhang.blogspot.dk/2015/01/setup-torquemaui-system.html
### Error 1:

```
pbs_mom: symbol lookup error: pbs_mom: undefined symbol: log_mutex
```
Solution:

```
echo '/usr/local/lib' > /etc/ld.so.conf.d/torque.conf
ldconfig
```

### Error 2:

```
socket_connect_unix failed: 15137
qstat: cannot connect to server (null) (errno=15137) could not connect to trqauthd
```
Solution:
* Make sure `trqauthd` is running with `pbs_mom`

## Other tutorials for installation
**NOTE**: These have not fully succeeded in my case.

http://willworkforscience.blogspot.dk/2012/01/quick-and-dirty-guide-for-parallelizing.html
https://jabriffa.wordpress.com/2015/02/11/installing-torquepbs-job-scheduler-on-ubuntu-14-04-lts/
* Ran into problems when `/etc/init.d/torque-server start`
* Removed everything
* Wrote `pbs_server -t create`, but gave
 `bash: /usr/local/sbin/pbs_server: No such file or directory`
http://ubuntuforums.org/showthread.php?t=1512061
This link lead to
http://ubuntuforums.org/showthread.php?t=1372508
also tried
https://enotacoes.wordpress.com/2010/06/15/installing-torque-in-ubuntu-9-04/
