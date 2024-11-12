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


THE_PLAN_TMP_DIR_NAME="tmp"
THE_PLAN_TMP_DIR_PATH="${THE_PLAN_DIR_PATH}/${THE_PLAN_TMP_DIR_NAME}"


##
### Tail: Path
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
		util_error_echo "> Ex: sudo ${THE_CMD_FILE_NAME} /opt/tmp/work/rootfs"
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
### Head: Model / Chroot
##

mod_before_chroot_bind () {

	local chroot_dir_path="${THE_CHROOT_DIR_PATH}"


	mount --bind /dev "${chroot_dir_path}/dev"
	mount --bind /run  "${chroot_dir_path}/run"
	#mount --bind /media  "${chroot_dir_path}/media"
	mount -t devpts devpts "${chroot_dir_path}/dev/pts"
	mount -t sysfs sysfs "${chroot_dir_path}/sys"
	mount -t proc proc "${chroot_dir_path}/proc"
	mount -t tmpfs tmpfs  "${chroot_dir_path}/dev/shm"
	mount --bind /tmp "${chroot_dir_path}/tmp"


	return 0

}

##
### Tail: Model / Chroot
################################################################################



################################################################################
### Head: Portal / Steps
##

mod_test () {



	return 0

}

mod_before_chroot () {

	#util_error_echo "mod_before_chroot"


	mod_before_chroot_bind


	return 0

}


portal_before_chroot () {

	#util_error_echo 'portal_before_chroot'

	sys_root_user_required

	sys_signal_bind


	mod_before_chroot

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
		util_error_echo "## ## Chroot Path Required"
		util_error_echo "##"
		util_error_echo

		util_error_echo
		util_error_echo "> Ex: sudo ${THE_CMD_FILE_NAME} /opt/tmp/work/rootfs"

		util_error_echo

		exit 1
	fi

}

sys_init_args () {

	THE_CHROOT_DIR_PATH="${1}"

}

##
### Tail: Args
################################################################################




################################################################################
### Head: Main
##

__main__ () {

	portal_before_chroot "${@}"

}

sys_check_args_size "${#}"

sys_init_args "${@}"

__main__ "${@}"

##
### Tail: Main
################################################################################

