#!/bin/bash

config_sshd() {
   # Create the PrivSep empty dir if necessary
   if [ ! -d /var/run/sshd ]; then
      mkdir /var/run/sshd
      chmod 0755 /var/run/sshd
   fi
   # Modify config file
   sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
   sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
   mkdir /root/.ssh
   cat /tmp/id_dsa.pub >> /root/.ssh/authorized_keys
}

runit_log() {
   adduser --system --no-create-home --group log
   mkdir /var/log/main
   chown log.log /var/log/main

   mkdir /etc/service/log
   echo -e "#!/bin/sh" > /etc/service/log/run
   echo -e 'exec 2>&1' >> /etc/service/log/run
   echo -e 'exec chpst -ulog svlogd -tt /var/log/main' >> /etc/service/log/run

   chown root.root /etc/service/log/run
   chmod 755 /etc/service/log/run
}

runit_sshd() {
   mkdir /etc/service/sshd
   echo -e "#!/bin/sh" > /etc/service/sshd/run
   echo -e 'exec 2>&1' >> /etc/service/sshd/run
   echo -e 'exec /usr/sbin/sshd -D -e' >> /etc/service/sshd/run

   chown root.root /etc/service/sshd/run
   chmod 755 /etc/service/sshd/run
}


config_sshd
runit_log
runit_sshd


exit 0
