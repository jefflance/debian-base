#!/bin/bash

: ${SSH_SIZEPASS:=}
: ${SSH_ROOTPASS:=$(tr -dc '[:alnum:]' < /dev/urandom | head -c ${SSH_SIZEPASS:-16})}


config_users() {
   echo "root:${SSH_ROOTPASS}" | chpasswd
   echo ssh root password: ${SSH_ROOTPASS}
}


config_users


exec "$@"
