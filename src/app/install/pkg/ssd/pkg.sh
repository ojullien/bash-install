## -----------------------------------------------------------------------------
## SSD.
## SSD install package functions.
##
## @package ojullien\bash\app\install\pkg\vimrc
## @license MIT <https://github.com/ojullien/bash-install/blob/master/LICENSE>
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## Constants
## -----------------------------------------------------------------------------
readonly m_INSTALL_SSD_FSTRIM_CRON="/etc/cron.weekly/fstrim"

## -----------------------------------------------------------------------------
## Functions
## -----------------------------------------------------------------------------
SSD::isSSD() {

    # Init
    local -i iReturn=1

    # Do the job
    grep 0 /sys/block/sda/queue/rotational > /dev/null 2>&1
    iReturn=$?
    if (( 0 == iReturn )); then
       String::success "\tSSD detected"
    else
       String::error "\tNo SSD detected"
    fi

    return ${iReturn}
}

SSD::supportTRIM() {

    # Init
    local -i iReturn=1

    # Do the job
    hdparm -I /dev/sda | grep TRIM > /dev/null 2>&1
    iReturn=$?
    if (( 0 == iReturn )); then
       String::success "\tSSD support TRIM"
    else
       String::error "\tSSD do not support TRIM"
    fi

    return ${iReturn}
}

SSD::optimizeSSD() {

    # Parameters
    if (( $# != 1 )) || [ -z "$1" ]; then
       String::error "Usage: Install::optimizeSSD <fstrim cron file path>"
        return 1
    fi

    # Init
    local -i iReturn=1
    local -a aFiles=("/usr/share/doc/util-linux/examples/fstrim.service" "/usr/share/doc/util-linux/examples/fstrim.timer")
    local sFile=""

    # Do the job
    if [[ -f $1 ]] || [ -f /etc/systemd/system/fstrim.timer ]; then
       String::success "\tSSD already optimized"
    else
        for sFile in "${aFiles[@]}"
        do
            FileSystem::copyFile "${sFile}" "/etc/systemd/system"
        done
        systemctl enable fstrim.timer
        iReturn=$?
        if (( 0 == iReturn )); then
           String::success "\tSSD optimized"
        else
           String::error "\tSSD not optimized"
        fi
    fi

    return ${iReturn}
}
