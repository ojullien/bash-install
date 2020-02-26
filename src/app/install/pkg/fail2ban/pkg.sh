## -----------------------------------------------------------------------------
## fail2ban.
## fail2ban install package functions.
##
## @package ojullien\bash\app\install\pkg\fail2ban
## @license MIT <https://github.com/ojullien/bash-install/blob/master/LICENSE>
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## Constants
## -----------------------------------------------------------------------------
readonly m_INSTALL_FAIL2BAN_DIR_REALPATH="${m_INSTALL_DIR_REALPATH}/pkg/fail2ban"
readonly m_INSTALL_FAIL2BAN_SYS="/etc/fail2ban/"

## -----------------------------------------------------------------------------
## Functions
## -----------------------------------------------------------------------------
Fail2Ban::configure() {

    # Init
    local sFile=""
    local -i iReturn=1
    local -a aFiles

    # Save current conf
    mapfile -t aFiles < <(find "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_new" -type f -iname '*.local' -printf "%f\n")
    iReturn=$?
    ((0!=iReturn)) && return ${iReturn}

    for sFile in "${aFiles[@]}"; do
        sCurrent="${m_INSTALL_FAIL2BAN_SYS}/${sFile}"
        FileSystem::moveFile "${sCurrent}" "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_saved/${m_DATE}_${sFile}"
        FileSystem::copyFile "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_new/${sFile}" "${sCurrent}"
        iReturn=$?
        ((0!=iReturn)) && return ${iReturn}
    done

    # Save current filter
    mapfile -t aFiles < <(find "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_new/filter.d" -type f -iname '*.conf' -printf "%f\n")
    iReturn=$?
    ((0!=iReturn)) && return ${iReturn}

    for sFile in "${aFiles[@]}"; do
        sCurrent="${m_INSTALL_FAIL2BAN_SYS}/filter.d/${sFile}"
        FileSystem::moveFile "${sCurrent}" "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_saved/${m_DATE}_${sFile}"
        FileSystem::copyFile "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_new/filter.d/${sFile}" "${sCurrent}"
        iReturn=$?
        ((0!=iReturn)) && return ${iReturn}
    done

    # Save current jail
    mapfile -t aFiles < <(find "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_new/jail.d" -type f -iname '*.conf' -printf "%f\n")
    iReturn=$?
    ((0!=iReturn)) && return ${iReturn}

    for sFile in "${aFiles[@]}"; do
        sCurrent="${m_INSTALL_FAIL2BAN_SYS}/jail.d/${sFile}"
        FileSystem::moveFile "${sCurrent}" "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_saved/${m_DATE}_${sFile}"
        FileSystem::copyFile "${m_INSTALL_FAIL2BAN_DIR_REALPATH}/conf_new/jail.d/${sFile}" "${sCurrent}"
        iReturn=$?
        ((0!=iReturn)) && return ${iReturn}
    done

    return ${iReturn}
}
