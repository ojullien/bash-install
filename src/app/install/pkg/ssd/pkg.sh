## -----------------------------------------------------------------------------
## SSD.
## SSD install package functions.
##
## @package ojullien\bash\app\install\pkg\ssd
## @license MIT <https://github.com/ojullien/bash-install/blob/master/LICENSE>
## -----------------------------------------------------------------------------

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

    # Init
    local -i iReturn=1

    # Do the job
    SSD::isSSD
    iReturn=$?
    ((0!=iReturn)) && return 0

    SSD::supportTRIM
    iReturn=$?
    ((0!=iReturn)) && return 0

    systemctl enable fstrim.timer
    iReturn=$?
    if (( 0 == iReturn )); then
       String::success "\tSSD optimized"
    else
       String::error "\tSSD not optimized"
    fi

    return ${iReturn}
}
