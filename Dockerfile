# debian-base
#   Custom base install of Debian based on my own 'debian-minbase' image.
#
#   SSH :
#   If you do not want to put a ssh public key you can use root access,
#   just comment the correct line.
#   The root password is set after being generated ramdomly.
#   You can view it threw the docker logs.

FROM jefflance/debian-minbase:latest
MAINTAINER Jeff LANCE <jeff.lance@mala.fr>


ENV DEBIAN_FRONTEND noninteractive


# update system packages, install some stuff and clean package cache
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends --auto-remove \
       runit \
       less \
       cron \
       openssh-server \
       sudo \
       curl \
       nano \
    && apt-get clean

# configure system
#COPY id_dsa.pub /tmp/id_dsa.pub
COPY configure.sh /tmp/configure.sh
RUN /bin/bash /tmp/configure.sh && rm /tmp/configure.sh # && rm /tmp/id_dsa.pub
COPY entrypoint.sh /entrypoint.sh


EXPOSE 22

# entrypoint is used to config users
ENTRYPOINT ["/entrypoint.sh"]
# start configured services
CMD ["/usr/sbin/runsvdir-start"]
