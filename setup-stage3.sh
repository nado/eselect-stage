#!/bin/bash

####
# Input processing
###

usage() {
	echo "$0 <chroot name> <chroot dir> <profile> [arch]"
	echo " arch defaults to amd64"
}

if [[ $# -le 2 ]]; then
	usage
	exit 1
fi

chroot_name="$1"
chroot_dir="$2"
profile="-$3"

if [[ $# -eq 4 ]]; then
	arch="$4"
else
	arch="amd64"
fi
distfiles_host="http://distfiles.gentoo.org"
distfiles_url="${distfiles_host}/releases/${arch}/autobuilds"
stage3_tar=""

####
# Functions
####

die() {
	echo "$1"
	exit 1
}

fetchLatestStage3() {
	local url="${distfiles_url}/latest-stage3-${arch}${profile}.txt"
	filename=$(curl -s "${url}"|tail -n1|cut -d' ' -f1) || die "Parameters incorrect"
	url="${distfiles_url}/${filename}"
	curl -C - -# "${url}" --output "$(echo ${filename}|cut -d'/' -f2)" || die "Could not fetch archive at designated path"
}

installStage() {
	mkdir -p "${chroot_dir}"

	tar xvpf "${stage3_tar}" -C "${chroot_dir}"

	# Portage conf
	mkdir -p "${chroot_dir}/etc/portage/repos.conf"
	cp "${chroot_dir}/usr/share/portage/config/repos.conf" "${chroot_dir}/etc/portage/repos.conf/gentoo.conf"
	sed 's/auto-sync = yes/auto-sync = no/' -i "${chroot_dir}/etc/portage/repos.conf/gentoo.conf"

	# Net conf
	cp -L /etc/resolv.conf "${chroot_dir}/etc/"
	echo 'export PS1="(chroot) $PS1"' >> "${chroot_dir}/etc/profile"

	# Mounts handled by mount-chroot
	ln -s mount-chroot "/etc/init.d/mount-chroot.${chroot_name}"

	local rc_conf="/etc/conf.d/mount-chroot.${chroot_name}"
	echo "CHROOT_PATH='${chroot_dir}'" >> "$rc_conf"
	echo "PORTAGE=1" >> "$rc_conf"
	
	echo "Mount the needed directories with rc-service mount-chroot.${chroot_name} start"
}

####
# Main
####

fetchLatestStage3
#installStage
