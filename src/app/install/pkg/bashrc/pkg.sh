## -----------------------------------------------------------------------------
## bashrc & bash_alias.
## bashrc & bash_alias install package functions.
##
## @package ojullien\bash\app\install\pkg\bashrc
## @license MIT <https://github.com/ojullien/bash-install/blob/master/LICENSE>
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## Constants
## -----------------------------------------------------------------------------
readonly m_INSTALL_BASHRC_DIR_REALPATH="${m_INSTALL_DIR_REALPATH}/pkg/bashrc"
readonly m_INSTALL_BASHALIASES_FILENAME="bash_aliases"

## -----------------------------------------------------------------------------
## Functions
## -----------------------------------------------------------------------------
BashRC::configureAliases() {

    # Parameters
    if (( $# != 2 )) || [[ -z "$1" ]] || [[ -z "$2" ]]; then
        String::error "Usage: BashRC::configureAliases <user> <home path>"
        return 1
    fi

    # Init
    local sUser="$1" sCurrent="$2/.${m_INSTALL_BASHALIASES_FILENAME}"
    local -i iReturn=1

    # Save current file
    FileSystem::moveFile "${sCurrent}" "${m_INSTALL_BASHRC_DIR_REALPATH}/conf_saved/${m_DATE}_${sUser}_${m_INSTALL_BASHALIASES_FILENAME}"

    # Do the job
    String::notice "Configuring ${sCurrent} ..."
    FileSystem::copyFile "${m_INSTALL_BASHRC_DIR_REALPATH}/conf_new/${m_INSTALL_BASHALIASES_FILENAME}" "${sCurrent}"
    iReturn=$?
    ((0!=iReturn)) && return ${iReturn}

    String::notice -n "Changing owner:"
    chown "${sUser}":"${sUser}" "${sCurrent}"
    iReturn=$?
    String::checkReturnValueForTruthiness ${iReturn}

    return ${iReturn}
}

BashRC::configure() {

    # Init
    local sUser=""
    local -i iReturn=1

    # Do the job
    String::notice "Configuring .bash_aliases ..."

    # Configure bash_aliases for root
    BashRC::configureAliases "root" "/root"
    iReturn=$?
    ((0!=iReturn)) && return ${iReturn}

    # Configure bash_aliases for users
    for sUser in "${m_INSTALL_USERS[@]}"; do
        BashRC::configureAliases "${sUser}" "/home/${sUser}"
        iReturn=$?
        ((0!=iReturn)) && return ${iReturn}
    done

    return ${iReturn}
}