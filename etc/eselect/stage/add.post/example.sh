#!/bin/bash

# Example of a `eselect stage add` post hook script
# This file must have +x rights in order to be called by eselect-stage

chroot_name=${1}
chroot_dir=${2}

cp /etc/portage/repos.conf/gentoo.conf ${chroot_dir}/etc/portage/repos.conf/gentoo.conf

sed -i -e 's/^auto-sync = yes/auto-sync = no/g' ${chroot_dir}/etc/portage/repos.conf/gentoo.conf
