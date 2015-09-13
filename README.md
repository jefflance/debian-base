# debian-base

## Docker container with ssh.

A Debian base image. Built on my own stock Debian minimal image from mkimage.sh script.


### Main tools included
- runit : to manage services under /etc/service/ dir
- openssh-server

see [Dockerfile](https://github.com/jefflance/debian-base/blob/master/Dockerfile) for details.


### SSH connection as root
Root password is ramdomly generated at launch and can be viewed through logs.
You can redefine it or set a size for the generated one with env vars : `SIZEPASS` and `ROOTPASS`.
The default pass size is 16 chars.

You can also use ssh autologin by adding your ssh public key (named `id_dsa.pub`) in Dockerfile directory and commenting out the correct lines in Dockerfile (line 31 and 33: concerning id_dsa.pub).

##### Examples :
- To set a new root password
`docker run -d -p 2222:22 --env="ROOTPASS=toor" jefflance/debian-base`
- To set a size for a ramdom root password
`docker run -d -p 2222:22 --env="SIZEPASS=6" jefflance/debian-base`

After container is launched, you can login :
`ssh -p 2222 root@docker-host`
