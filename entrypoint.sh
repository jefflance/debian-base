#!/bin/bash

: ${SIZEPASS:=}
: ${ROOTPASS:=$(tr -dc '[:alnum:]' < /dev/urandom | head -c ${SIZEPASS:-16})}


config_users() {
   echo "root:${ROOTPASS}" | chpasswd
   echo ssh root password: ${ROOTPASS}
}


config_users


exec "$@"
