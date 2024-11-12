#!/usr/bin/env bash


################################################################################
### Head: Note
##

##
## ## Link
##
## * https://github.com/samwsteps/skel-project-plan/blob/master/develop/sh/project-stepser/basic/stepser/bin/prepare.sh
##

##
### Tail: Note
################################################################################


################################################################################
### Head: Init
##

THE_BASE_DIR_PATH="$(cd -- "$(dirname -- "${0}")" ; pwd)"
THE_INIT_DIR_PATH="${THE_BASE_DIR_PATH}/."
#. "${THE_INIT_DIR_PATH}/util.sh"

THE_CMD_FILE_NAME="$(basename "$0")"

##
### Tail: Init
################################################################################




################################################################################
### Head: Path
##


THE_PLAN_DIR_PATH="${THE_BASE_DIR_PATH}"


THE_PLAN_ASSET_DIR_NAME="asset"
THE_PLAN_ASSET_DIR_PATH="${THE_PLAN_DIR_PATH}/${THE_PLAN_ASSET_DIR_NAME}"


THE_PLAN_FACTORY_DIR_NAME="factory"
THE_PLAN_FACTORY_DIR_PATH="${THE_PLAN_DIR_PATH}/${THE_PLAN_FACTORY_DIR_NAME}"


THE_PLAN_TMP_DIR_NAME="tmp"
THE_PLAN_TMP_DIR_PATH="${THE_PLAN_DIR_PATH}/${THE_PLAN_TMP_DIR_NAME}"

#THE_PLAN_TMP_DIR_PATH="${HOME}/${THE_PLAN_TMP_DIR_NAME}"
THE_PLAN_TMP_DIR_PATH="/opt/${THE_PLAN_TMP_DIR_NAME}"


THE_PLAN_WORK_DIR_NAME="work"
THE_PLAN_WORK_DIR_PATH="${THE_PLAN_TMP_DIR_PATH}/${THE_PLAN_WORK_DIR_NAME}"

THE_PLAN_OUT_DIR_NAME="out"
THE_PLAN_OUT_DIR_PATH="${THE_PLAN_TMP_DIR_PATH}/${THE_PLAN_OUT_DIR_NAME}"




THE_PLAN_PROFILE_DIR_NAME="profile"
THE_PLAN_PROFILE_DIR_PATH="${THE_PLAN_TMP_DIR_PATH}/${THE_PLAN_PROFILE_DIR_NAME}"




THE_OVERLAY_DIR_NAME="overlay"
THE_OVERLAY_DIR_PATH="${THE_PLAN_ASSET_DIR_PATH}/${THE_OVERLAY_DIR_NAME}"

THE_FACTORY_OVERLAY_DIR_NAME="${THE_OVERLAY_DIR_NAME}"
THE_FACTORY_OVERLAY_DIR_PATH="${THE_PLAN_FACTORY_DIR_PATH}/${THE_FACTORY_OVERLAY_DIR_NAME}"




THE_ISO_TEMPLATE_SOURCE_DIR_NAME="iso-template"
THE_ISO_TEMPLATE_SOURCE_DIR_PATH="${THE_PLAN_FACTORY_DIR_PATH}/${THE_ISO_TEMPLATE_SOURCE_DIR_NAME}"


THE_ISO_TEMPLATE_TARGET_DIR_NAME="${THE_ISO_TEMPLATE_SOURCE_DIR_NAME}"
THE_ISO_TEMPLATE_TARGET_DIR_PATH="${THE_PLAN_WORK_DIR_PATH}/${THE_ISO_TEMPLATE_TARGET_DIR_NAME}"




THE_PACKAGE_LIST_DIR_NAME="package"
THE_PACKAGE_LIST_DIR_PATH="${THE_PLAN_ASSET_DIR_PATH}/${THE_PACKAGE_LIST_DIR_NAME}"


THE_PACKAGE_INSTALL_DIR_NAME="install"
THE_PACKAGE_INSTALL_DIR_PATH="${THE_PACKAGE_LIST_DIR_PATH}/${THE_PACKAGE_INSTALL_DIR_NAME}"


THE_PACKAGE_REMOVE_DIR_NAME="remove"
THE_PACKAGE_REMOVE_DIR_PATH="${THE_PACKAGE_LIST_DIR_PATH}/${THE_PACKAGE_REMOVE_DIR_NAME}"




THE_INSTALLER_SETTING_DIR_NAME="calamares"
THE_INSTALLER_SETTING_DIR_PATH="${THE_PLAN_ASSET_DIR_PATH}/installer/${THE_INSTALLER_SETTING_DIR_NAME}"




THE_HOOK_DIR_NAME="hook"
THE_HOOK_DIR_PATH="${THE_PLAN_FACTORY_DIR_PATH}/${THE_HOOK_DIR_NAME}"




##
### Tail: Path
################################################################################




################################################################################
### Head: Option / DEFAULT_RUN
##

THE_DEFAULT_RUN="${THE_DEFAULT_RUN:=make-iso}"

sys_default_run () {
	echo "${THE_DEFAULT_RUN}"
}

##
### Tail: Option / DEFAULT_RUN
################################################################################




################################################################################
### Head: Master / Path
##

THE_MASTER_OS_ROOT_DIR_NAME="rootfs"
THE_MASTER_OS_ROOT_DIR_PATH="${THE_PLAN_WORK_DIR_PATH}/${THE_MASTER_OS_ROOT_DIR_NAME}"


THE_MASTER_OS_ARCHIVE_FILE_NAME="filesystem.squashfs"
THE_MASTER_OS_ARCHIVE_FILE_PATH="${THE_PLAN_WORK_DIR_PATH}/${THE_MASTER_OS_ARCHIVE_FILE_NAME}"




THE_LIVE_DEB_MIDDLE_DIR_NAME="live-deb"
THE_LIVE_DEB_MIDDLE_DIR_PATH="${THE_PLAN_WORK_DIR_PATH}/${THE_LIVE_DEB_MIDDLE_DIR_NAME}"


THE_LIVE_DEB_SOURCE_DIR_NAME="archives"
THE_LIVE_DEB_SOURCE_DIR_PATH="${THE_MASTER_OS_ROOT_DIR_PATH}/var/cache/apt/${THE_LIVE_DEB_SOURCE_DIR_NAME}"


##
### Tail: Master / Path
################################################################################




################################################################################
### Head: Master / Option
##

THE_PACKAGE_CONTROL_AGENT="${THE_PACKAGE_CONTROL_AGENT:=apt-get}"


THE_BUILD_ARCH="${THE_BUILD_ARCH:=amd64}"
THE_BUILD_SUITE="${THE_BUILD_SUITE:=bookworm}"
THE_PACKAGE_REPO_URL="${THE_PACKAGE_REPO_URL:=http://deb.debian.org/debian/}"


##
### Tail: Master / Option
################################################################################




################################################################################
### Head: Util / Debug
##

util_error_echo () {
	echo "$@" 1>&2
}

##
### Head: Util / Debug
################################################################################




################################################################################
### Head: Signal
##

exit_on_signal_interrupted () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## **Script Interrupted**"
	util_error_echo "##"
	util_error_echo

	sys_clean_on_exit

	sleep 2

	exit 0

}

exit_on_signal_terminated () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## **Script Terminated**"
	util_error_echo "##"
	util_error_echo

	sys_clean_on_exit

	sleep 2

	exit 0

}

sys_signal_bind () {

	trap exit_on_signal_interrupted SIGINT
	trap exit_on_signal_terminated SIGTERM

}

##
### Tail: Signal
################################################################################




################################################################################
### Head: Limit Run User
##

sys_root_user_required () {

	if [[ "${EUID}" == 0 ]]; then

		return 0

	else

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Please Run As Root"
		util_error_echo "##"

		util_error_echo
		util_error_echo "> Ex: sudo ${THE_CMD_FILE_NAME} amd64"
		util_error_echo

		#sleep 2
		exit 0
	fi

}

##
### Tail: Limit Run User
################################################################################




################################################################################
### Head: Clean
##

sys_clean_on_prepare () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## Cleaning Data On Prepare"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo "rm -rf ${THE_PLAN_TMP_DIR_PATH}"
	rm -rf "${THE_PLAN_TMP_DIR_PATH}"


	util_error_echo

}

sys_clean_on_exit () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## Cleaning Data On Exit"
	util_error_echo "##"
	util_error_echo



}

sys_clean_on_finish () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## Cleaning Data On Finish"
	util_error_echo "##"
	util_error_echo


}

##
### Tail: Clean
################################################################################




################################################################################
### Head: Requirements
##

sys_package_required () {

	#return 0

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Check Package Required"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo "apt-get install debootstrap debian-archive-keyring debian-ports-archive-keyring qemu-user-static genisoimage squashfs-tools -y"
	util_error_echo
	apt-get install debootstrap debian-archive-keyring debian-ports-archive-keyring qemu-user-static genisoimage squashfs-tools -y

	util_error_echo



}

##
### Tail: Requirements
################################################################################


################################################################################
### Head: Util / Package List
##

util_package_find_list () {
	local file_path="$1"
	cat $file_path  | while IFS='' read -r line; do
		trim_line=$(echo $line) # trim

		## https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
		## ignore leading #
		if [ "${trim_line:0:1}" == '#' ]; then
			continue;
		fi

		## ignore empty line
		if [[ -z "$trim_line" ]]; then
			continue;
		fi

		echo "$line"
	done
}

##
### Tail: Util / Package List
################################################################################




################################################################################
### Head: Model / Build Target OS / Overlay
##

mod_target_os_factory_overlay () {

	local overlay_dir_path="${THE_FACTORY_OVERLAY_DIR_PATH}"
	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Factory Overlay"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo cp -rf "${overlay_dir_path}/." "${rootfs}"
	cp -rf "${overlay_dir_path}/." "${rootfs}"

	return 0
}

mod_target_os_overlay () {

	local overlay_dir_path="${THE_OVERLAY_DIR_PATH}"
	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Overlay"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo cp -rf "${overlay_dir_path}/." "${rootfs}"
	cp -rf "${overlay_dir_path}/." "${rootfs}"

	return 0
}

##
### Tail: Model / Build Target OS / Overlay
################################################################################




################################################################################
### Head: Model / Build Target OS / Locale
##

mod_target_os_factory_locale () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Factory Locale"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo sys_chroot_package_control install locales -y
	util_error_echo
	sys_chroot_package_control install locales -y

	util_error_echo
	util_error_echo sys_chroot_run locale-gen
	util_error_echo
	sys_chroot_run locale-gen

	return 0

}

mod_target_os_locale () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Locale"
	util_error_echo "##"
	util_error_echo

	#util_error_echo
	#util_error_echo sys_chroot_package_control install locales -y
	#util_error_echo
	#sys_chroot_package_control install locales -y

	util_error_echo
	util_error_echo sys_chroot_run locale-gen
	util_error_echo
	sys_chroot_run locale-gen

	return 0

}

##
### Tail: Model / Build Target OS / Locale
################################################################################




################################################################################
### Head: Model / Build Target OS / Package Management
##

mod_target_os_package_management () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Package Management"
	util_error_echo "##"
	util_error_echo




	mod_target_os_package_install_keyring


	mod_target_os_package_install_live
	mod_target_os_package_install_network


	mod_target_os_package_install_each
	mod_target_os_package_remove_each


	mod_target_os_package_install_kernel
	mod_target_os_package_install_driver


	mod_target_os_package_install_grub


	mod_target_os_package_clean
	mod_target_os_package_downlod


	return 0
}

mod_target_os_package_install_keyring () {

	util_error_echo
	util_error_echo sys_chroot_package_control install debian-ports-archive-keyring debian-archive-keyring -y
	util_error_echo
	sys_chroot_package_control install debian-ports-archive-keyring debian-archive-keyring -y

	util_error_echo
	util_error_echo sys_chroot_package_control update -o Acquire::Check-Valid-Until=false
	util_error_echo
	sys_chroot_package_control update -o Acquire::Check-Valid-Until=false


	return 0
}

mod_target_os_package_install_live () {

	util_error_echo
	util_error_echo sys_chroot_package_control install live-task-recommended live-task-standard live-config-systemd live-boot -y
	util_error_echo
	sys_chroot_package_control install live-task-recommended live-task-standard live-config-systemd live-boot -y


	return 0
}

mod_target_os_package_install_network () {

	util_error_echo
	util_error_echo sys_chroot_package_control install network-manager-gnome -y
	util_error_echo
	sys_chroot_package_control install network-manager-gnome -y


	return 0
}

mod_target_os_package_install_each () {

	local list_dir_path="${THE_PACKAGE_INSTALL_DIR_PATH}"

	local list_file_path=""

	for list_file_path in "${list_dir_path}"/*.txt; do

		#util_error_echo ${list_file_path}

		util_error_echo
		util_error_echo sys_chroot_package_control install $(util_package_find_list ${list_file_path}) -y
		util_error_echo
		sys_chroot_package_control install $(util_package_find_list ${list_file_path}) -y

	done


	return 0

}

mod_target_os_package_remove_each () {

	local list_dir_path="${THE_PACKAGE_REMOVE_DIR_PATH}"

	local list_file_path=""

	for list_file_path in "${list_dir_path}"/*.txt; do

		#util_error_echo ${list_file_path}

		util_error_echo
		util_error_echo sys_chroot_package_control remove $(util_package_find_list ${list_file_path}) -y
		util_error_echo
		sys_chroot_package_control remove $(util_package_find_list ${list_file_path}) -y

	done


	return 0

}

mod_target_os_package_install_kernel () {

	util_error_echo
	util_error_echo sys_chroot_package_control install linux-headers-generic linux-image-generic -y
	util_error_echo
	sys_chroot_package_control install linux-headers-generic linux-image-generic -y


	return 0
}

mod_target_os_package_install_driver () {

	util_error_echo
	util_error_echo sys_chroot_package_control install firmware-linux firmware-linux-free firmware-linux-nonfree -y
	util_error_echo
	sys_chroot_package_control install firmware-linux firmware-linux-free firmware-linux-nonfree -y


	util_error_echo
	util_error_echo sys_chroot_package_control install firmware-iwlwifi firmware-realtek -y
	util_error_echo
	sys_chroot_package_control install firmware-iwlwifi firmware-realtek -y


	return 0
}

mod_target_os_package_install_grub () {

	util_error_echo
	util_error_echo sys_chroot_package_control install grub-common -y
	util_error_echo
	sys_chroot_package_control install grub-common -y


	return 0
}

mod_target_os_package_clean () {

	util_error_echo
	util_error_echo sys_chroot_package_control autoremove -y
	util_error_echo
	sys_chroot_package_control autoremove -y


	util_error_echo
	util_error_echo sys_chroot_package_control clean -y
	util_error_echo
	sys_chroot_package_control clean -y


	return 0
}

mod_target_os_package_downlod () {

	local build_arch="${THE_BUILD_ARCH}"


	util_error_echo
	util_error_echo sys_chroot_package_control install grub-pc --download-only -y
	util_error_echo
	sys_chroot_package_control install grub-pc --download-only -y


	util_error_echo
	util_error_echo sys_chroot_package_control install "grub-efi-${build_arch}" --download-only -y
	util_error_echo
	sys_chroot_package_control install "grub-efi-${build_arch}" --download-only -y

	util_error_echo
	util_error_echo sys_chroot_package_control install grub-efi --download-only -y
	util_error_echo
	sys_chroot_package_control install grub-efi --download-only -y

	util_error_echo
	util_error_echo sys_chroot_package_control install grub-common --download-only -y
	util_error_echo
	sys_chroot_package_control install grub-common --download-only -y

	util_error_echo
	util_error_echo sys_chroot_package_control install cryptsetup-initramfs cryptsetup keyutils --download-only -y
	util_error_echo
	sys_chroot_package_control install cryptsetup-initramfs cryptsetup keyutils --download-only -y




	util_error_echo
	util_error_echo mkdir -p "${THE_LIVE_DEB_MIDDLE_DIR_PATH}"
	util_error_echo
	mkdir -p "${THE_LIVE_DEB_MIDDLE_DIR_PATH}"


	util_error_echo
	util_error_echo cp -v "${THE_LIVE_DEB_SOURCE_DIR_PATH}"/*.deb "${THE_LIVE_DEB_MIDDLE_DIR_PATH}"
	util_error_echo
	cp -v "${THE_LIVE_DEB_SOURCE_DIR_PATH}"/*.deb "${THE_LIVE_DEB_MIDDLE_DIR_PATH}"


	util_error_echo
	util_error_echo sys_chroot_package_control clean -y
	util_error_echo
	sys_chroot_package_control clean -y


	return 0
}

##
### Tail: Model / Build Target OS / Package Management
################################################################################




################################################################################
### Head: Model / Build Target OS / Installer
##

mod_target_os_installer () {

	local installer_setting_dir_path="${THE_INSTALLER_SETTING_DIR_PATH}"
	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Installer"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo sys_chroot_package_control install calamares calamares-settings-debian -y
	util_error_echo
	sys_chroot_package_control install calamares calamares-settings-debian -y


	util_error_echo
	util_error_echo cp -rf "${installer_setting_dir_path}/." "${rootfs}/etc/calamares"
	cp -rf "${installer_setting_dir_path}/." "${rootfs}/etc/calamares"


	return 0

}

##
### Tail: Model / Build Target OS / Installer
################################################################################




################################################################################
### Head: Model / Build Target OS / Hook
##

mod_target_os_hook () {

	local hook_source_dir_path="${THE_HOOK_DIR_PATH}"
	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"
	local chroot_hook_dir_path="/opt/tmp/work/hook"
	local hook_middle_dir_path="${rootfs}${chroot_hook_dir_path}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Hook"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo rm -rf "${hook_middle_dir_path}"
	rm -rf "${hook_middle_dir_path}"


	util_error_echo
	util_error_echo mkdir -p "${hook_middle_dir_path}"
	mkdir -p "${hook_middle_dir_path}"


	util_error_echo
	util_error_echo cp -rf "${hook_source_dir_path}/." "${hook_middle_dir_path}"
	cp -rf "${hook_source_dir_path}/." "${hook_middle_dir_path}"


	local hook_file_path=""
	local hook_file_name=""
	local chroot_hook_file_path=""

	for hook_file_path in "${hook_middle_dir_path}"/*.hook.chroot; do

		hook_file_name="$(basename ${hook_file_path})"
		chroot_hook_file_path="${chroot_hook_dir_path}/${hook_file_name}"

		#util_error_echo "${hook_file_path}"
		#util_error_echo "${hook_file_name}"
		#util_error_echo "${chroot_hook_file_path}"

		if [[ ! -x "${hook_file_path}" ]]; then
			continue;
		fi

		util_error_echo
		util_error_echo sys_chroot_run "${chroot_hook_file_path}"
		util_error_echo
		sys_chroot_run "${chroot_hook_file_path}"

	done


	return 0

}

##
### Tail: Model / Build Target OS / Hook
################################################################################




################################################################################
### Head: Model / Build Target OS / Clean
##

mod_target_os_clean () {

	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Clean"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo rm -rf "${rootfs}/var/log"/*
	rm -rf "${rootfs}/var/log"/*


	util_error_echo
	util_error_echo rm -rf "${rootfs}/root/.bash_history"
	util_error_echo
	rm -rf "${rootfs}/root/.bash_history"


	util_error_echo
	util_error_echo rm -rf "${rootfs}/initrd.img.old"
	util_error_echo
	rm -rf "${rootfs}/initrd.img.old"


	util_error_echo
	util_error_echo rm -rf "${rootfs}/vmlinuz.old"
	util_error_echo
	rm -rf "${rootfs}/vmlinuz.old"


	return 0
}

##
### Tail: Model / Build Target OS / Clean
################################################################################






################################################################################
### Head: Model / Build Target OS / Before Chroot
##

mod_target_os_before_chroot () {

	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"
	local agent="${THE_PLAN_DIR_PATH}/before-chroot.sh"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Before Chroot"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo bash "${agent}" "${rootfs}"
	bash "${agent}" "${rootfs}"




	return 0

}

##
### Tail: Model / Build Target OS / Before Chroot
################################################################################




################################################################################
### Head: Model / Build Target OS
##

mod_target_os_dir_prepare () {

	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	if [[ -d "${rootfs}" ]]; then

		sys_target_os_unmount "${rootfs}"
		rm -rf "${rootfs}"

	fi

	##mkdir -p "${rootfs}"

}

mod_target_os_bootstrap () {

	## https://manpages.debian.org/stable/debootstrap/debootstrap.8.en.html

	local build_arch="${THE_BUILD_ARCH}"
	local build_suite="${THE_BUILD_SUITE}"
	local package_repo_url="${THE_PACKAGE_REPO_URL}"
	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	if [[ "${build_arch}" == "loong64" ]]; then
		#debootstrap --no-check-gpg --keyring=/usr/share/keyrings/debian-ports-archive-keyring.gpg --arch $1 unstable "$rootfs" https://packages.gxde.org/debian-loong64/

		util_error_echo
		util_error_echo "## Not Suport"
		util_error_echo

		exit 0

	else

		util_error_echo
		util_error_echo debootstrap --arch "${build_arch}" "${build_suite}" "$rootfs" "${package_repo_url}"
		util_error_echo
		debootstrap --arch "${build_arch}" "${build_suite}" "$rootfs" "${package_repo_url}"

	fi

}

mod_target_os_archive () {

	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"
	local os_archive_file_path="${THE_MASTER_OS_ARCHIVE_FILE_PATH}"

	util_error_echo
	util_error_echo cd "${rootfs}"
	cd "${rootfs}"

	util_error_echo
	util_error_echo rm -rf "${os_archive_file_path}"
	rm -rf "${os_archive_file_path}"

	util_error_echo
	util_error_echo mksquashfs * "${os_archive_file_path}"
	mksquashfs * "${os_archive_file_path}"


	util_error_echo
	util_error_echo cd "${OLDPWD}"
	cd "${OLDPWD}"

}

##
### Tail: Model / Build Target OS
################################################################################




################################################################################
### Head: Model / Build Target ISO
##

mod_target_iso_create () {

	util_error_echo
	util_error_echo rm -rf "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"
	rm -rf "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"

	util_error_echo
	util_error_echo mkdir -p "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"
	mkdir -p "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"


	util_error_echo
	util_error_echo cp -rf "${THE_ISO_TEMPLATE_SOURCE_DIR_PATH}/." "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"
	cp -rf "${THE_ISO_TEMPLATE_SOURCE_DIR_PATH}/." "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"



	local build_arch="${THE_BUILD_ARCH}"
	local build_agent="./${build_arch}-build.sh"
	local build_agent_path="${THE_ISO_TEMPLATE_TARGET_DIR_PATH}/${build_arch}-build.sh"
	local build_arch_dir_path="${THE_ISO_TEMPLATE_TARGET_DIR_PATH}/${build_arch}"

	local os_archive_file_path="${THE_MASTER_OS_ARCHIVE_FILE_PATH}"

	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"


	if [[ ! -f "${build_agent_path}" ]]; then

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Build iso script not exists: "
		util_error_echo "##"

		util_error_echo
		util_error_echo "> ${build_agent_path}"
		util_error_echo

		exit 1
	fi




	##
	## ## prepare dir
	##
	mkdir -p "${build_arch_dir_path}/live"
	mkdir -p "${build_arch_dir_path}/deb"


	##
	## ## add deb package
	##
	util_error_echo
	util_error_echo cd "${build_arch_dir_path}/deb"
	cd "${build_arch_dir_path}/deb"


	util_error_echo
	util_error_echo mkdir -p "${THE_LIVE_DEB_MIDDLE_DIR_PATH}"
	util_error_echo
	./addmore.py "${THE_LIVE_DEB_MIDDLE_DIR_PATH}"/*.deb


	util_error_echo
	util_error_echo cd "${OLDPWD}"
	cd "${OLDPWD}"




	##
	## ## copy kernel
	##

	local kernel_number=$(ls -1 ${rootfs}/boot/vmlinuz-* | wc -l)
	local vmlinuz_list=($(ls -1 ${rootfs}/boot/vmlinuz-* | sort -rV))
	local initrd_list=($(ls -1 ${rootfs}/boot/initrd.img-* | sort -rV))

	#util_error_echo "kernel_number=${kernel_number}"
	#util_error_echo "vmlinuz_list=${vmlinuz_list}"
	#util_error_echo "initrd_list=${initrd_list}"

	local i=0

	for i in $( seq 0 $(expr ${kernel_number} - 1) ); do

		if [[ ${i} == 0 ]]; then
			cp "${vmlinuz_list[i]}" "${build_arch_dir_path}/live/vmlinuz" -v
			cp "${initrd_list[i]}" "${build_arch_dir_path}/live/initrd.img" -v
		fi

		if [[ ${i} == 1 ]]; then
			cp "${vmlinuz_list[i]}" "${build_arch_dir_path}/live/vmlinuz-oldstable" -v
			cp "${initrd_list[i]}" "${build_arch_dir_path}/live/initrd.img-oldstable" -v
		fi

	done


	##
	## ## prepare os archive
	##
	util_error_echo
	mv "${os_archive_file_path}" "${build_arch_dir_path}/live/filesystem.squashfs" -v
	util_error_echo
	#cp "${os_archive_file_path}" "${build_arch_dir_path}/live/filesystem.squashfs" -v
	#util_error_echo


	##
	## ## iso build head
	##
	util_error_echo
	util_error_echo cd "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"
	cd "${THE_ISO_TEMPLATE_TARGET_DIR_PATH}"


	##
	## ## iso build start
	##
	util_error_echo
	util_error_echo bash "${build_agent}"
	util_error_echo
	bash "${build_agent}"


	##
	## ## iso build tail
	##
	util_error_echo
	util_error_echo "cd ${OLDPWD}"
	cd "${OLDPWD}"


	return 0
}

##
### Tail: Model / Build Target ISO
################################################################################



################################################################################
### Head: Model / Build ISO
##

mod_iso_make_prepare () {

	sys_package_required

	sys_clean_on_prepare

	#mod_iso_profile_prepare

}


mod_iso_make_start () {

	local to_run="to_$(sys_default_run)"

	if [ "${to_run}" != "to_make-iso" ]; then
		return
	fi

	mod_iso_make_start_create_iso

}

mod_iso_make_start_create_iso () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## Building New ISO"
	util_error_echo "##"
	util_error_echo

	#sleep 5

	util_error_echo "## TODO: mod_iso_make_start_create_iso"
	return 0

	util_error_echo
	util_error_echo "cd ${THE_PLAN_PROFILE_DIR_PATH}"
	cd "${THE_PLAN_PROFILE_DIR_PATH}"


	util_error_echo
	util_error_echo "do build"
	#lb build


	util_error_echo
	util_error_echo "cd ${OLDPWD}"
	cd "${OLDPWD}"


	util_error_echo
	util_error_echo


}

mod_iso_make_finish () {

	mod_iso_make_copy_to_store

	sys_clean_on_finish

}

mod_iso_make_copy_to_store () {

	util_error_echo "## TODO: mod_iso_make_copy_to_store"

	return 0

	local iso_store_dir_path="../../../../iso/"

	if ! [ -d "${iso_store_dir_path}" ]; then
		return
	fi

	cp -a out/*.iso "${iso_store_dir_path}/"
}

mod_iso_build () {

	mod_iso_make_prepare
	mod_iso_make_start
	mod_iso_make_finish

}

##
### Tail: Model / Build ISO
################################################################################



################################################################################
### Head: Sys / Build ISO
##


##
## https://github.com/GXDE-OS/gxde-iso-builder/blob/main/build-squashfs.sh#L9-L18
##

function sys_chroot_run () {

	#util_error_echo "${@}"
	#return 0


	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	local i=1

	for i in {1..5}; do

		#sudo env DEBIAN_FRONTEND=noninteractive chroot "${rootfs}" "${@}"
		DEBIAN_FRONTEND=noninteractive chroot "${rootfs}" "${@}"

		if [[ $? == 0 ]]; then
			break
		fi

		sleep 1

	done

}


##
## https://github.com/GXDE-OS/gxde-iso-builder/blob/main/build-squashfs.sh#L2-L8
##

function sys_chroot_package_control () {

	if [[ ${THE_PACKAGE_CONTROL_AGENT} == "apt" ]]; then

		sys_chroot_run apt "${@}"

	else

		sys_chroot_run apt-get "${@}"

	fi

}


##
## https://github.com/GXDE-OS/gxde-iso-builder/blob/main/build-squashfs.sh#L19-L36
##

function mod_target_os_unmount () {

	local rootfs="${THE_MASTER_OS_ROOT_DIR_PATH}"

	sys_target_os_unmount "${rootfs}"

}

function sys_target_os_unmount () {

	local rootfs="${1}"

	umount "${rootfs}/sys/firmware/efi/efivars"
	umount "${rootfs}/sys"
	umount "${rootfs}/dev/pts"
	umount "${rootfs}/dev/shm"
	umount "${rootfs}/dev"

	umount "${rootfs}/sys/firmware/efi/efivars"
	umount "${rootfs}/sys"
	umount "${rootfs}/dev/pts"
	umount "${rootfs}/dev/shm"
	umount "${rootfs}/dev"

	umount "${rootfs}/run"
	umount "${rootfs}/media"
	umount "${rootfs}/proc"
	umount "${rootfs}/tmp"
}


##
### Tail: Sys / Build ISO
################################################################################



################################################################################
### Head: Portal / Steps
##

mod_test () {


	#sys_package_required


	#mod_target_os_dir_prepare
	#mod_target_os_bootstrap
	#mod_target_os_before_chroot


	#mod_target_os_factory_overlay
	#mod_target_os_factory_locale


	#mod_target_os_package_management
	#mod_target_os_overlay
	#mod_target_os_locale
	#mod_target_os_installer
	#mod_target_os_hook


	#mod_target_os_clean
	#sleep 5
	#mod_target_os_unmount
	#sleep 5

	#mod_target_os_archive
	mod_target_iso_create


	return 0

}

mod_steps () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## mod_steps"
	util_error_echo "##"
	util_error_echo


	sys_package_required


	mod_target_os_dir_prepare
	mod_target_os_bootstrap
	mod_target_os_before_chroot


	mod_target_os_factory_overlay
	mod_target_os_factory_locale


	mod_target_os_package_management
	mod_target_os_overlay
	mod_target_os_locale
	mod_target_os_installer
	mod_target_os_hook


	mod_target_os_clean
	sleep 5
	mod_target_os_unmount
	sleep 5


	mod_target_os_archive
	mod_target_iso_create


	return 0

}

mod_steps_old () {

	util_error_echo "mod_steps_old"


	mod_iso_build


	return 0

}


portal_steps () {

	#util_error_echo 'portal_steps'

	sys_root_user_required

	sys_signal_bind


	mod_steps

	#mod_test


	return 0

}

##
### Tail: Portal / Steps
################################################################################




################################################################################
### Head: Args
##

sys_check_args_size () {

	local args_size="${1}"

	if [[ ${1} -le 0 ]]; then

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Build Arch Required"
		util_error_echo "##"
		util_error_echo

		util_error_echo "> Build Arch Options: i386 amd64 arm64 mips64el loong64"
		util_error_echo
		util_error_echo "> Ex: sudo ${THE_CMD_FILE_NAME} amd64"

		util_error_echo

		exit 1
	fi

}

sys_init_args () {

	THE_BUILD_ARCH="${1}"

}

##
### Tail: Args
################################################################################




################################################################################
### Head: Main
##

__main__ () {

	portal_steps "${@}"

}

sys_check_args_size "${#}"

sys_init_args "${@}"

__main__ "${@}"

##
### Tail: Main
################################################################################
