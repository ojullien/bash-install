#!/bin/bash
## -----------------------------------------------------------------------------
## Linux Scripts.
## Install system.
##
## @package ojullien\bash\bin
## @license MIT <https://github.com/ojullien/bash-install/blob/master/LICENSE>
## -----------------------------------------------------------------------------
#set -o errexit
set -o nounset
set -o pipefail

## -----------------------------------------------------------------------------
## Shell scripts directory, eg: /root/work/Shell/src/bin
## -----------------------------------------------------------------------------
readonly m_DIR_REALPATH="$(realpath "$(dirname "$0")")"

## -----------------------------------------------------------------------------
## Load constants
## -----------------------------------------------------------------------------
# shellcheck source=/dev/null
. "${m_DIR_REALPATH}/../sys/constant.sh"

## -----------------------------------------------------------------------------
## Includes sources & configuration
## -----------------------------------------------------------------------------
# shellcheck source=/dev/null
. "${m_DIR_SYS}/runasroot.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/string.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/filesystem.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/option.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/config.sh"
# shellcheck source=/dev/null
. "${m_DIR_SYS}/package.sh"
#Config::load "manageservices"
Config::load "install"
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/app.sh"

## -----------------------------------------------------------------------------
## Help
## -----------------------------------------------------------------------------
((m_OPTION_SHOWHELP)) && Install::showHelp && exit 0

## -----------------------------------------------------------------------------
## Trace
## -----------------------------------------------------------------------------
Constant::trace
Install::trace

## -----------------------------------------------------------------------------
## Start
## -----------------------------------------------------------------------------
String::separateLine
String::notice "Today is: $(date -R)"
String::notice "The PID for $(basename "$0") process is: $$"
Console::waitUser

## -----------------------------------------------------------------------------
## Install first need packages
## -----------------------------------------------------------------------------
String::separateLine
Package::install --yes --quiet ${m_INSTALL_PACKAGES_FIRST}
Console::waitUser

## -----------------------------------------------------------------------------
## Release codename
## -----------------------------------------------------------------------------
declare -i iReturn=0
declare sReleaseCodename=""
sReleaseCodename="$(lsb_release --short --codename)"
if [[ -z "${sReleaseCodename}" ]] || [[ "n/a" = "${sReleaseCodename}" ]]; then
    sReleaseCodename='testing'
fi

## -----------------------------------------------------------------------------
## Configures sources file
## -----------------------------------------------------------------------------
String::separateLine
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/pkg/sources.list/pkg.sh"
String::notice "Configuring sources.list ..."
SourcesList::configure "${sReleaseCodename}"
iReturn=$?
String::notice -n "Configure sources.list:"
String::checkReturnValueForTruthiness ${iReturn}
Console::waitUser

## -----------------------------------------------------------------------------
## Updates & upgrades
## -----------------------------------------------------------------------------
String::separateLine
Package::upgrade
Console::waitUser

## -----------------------------------------------------------------------------
## Uninstall packages
## -----------------------------------------------------------------------------
String::separateLine
Package::uninstall --yes --quiet ${m_INSTALL_PACKAGES_PURGE}
Console::waitUser

## -----------------------------------------------------------------------------
## Install packages system
## -----------------------------------------------------------------------------
String::separateLine
Package::install --yes --quiet ${m_INSTALL_PACKAGES_SYSTEM}
Console::waitUser

## -----------------------------------------------------------------------------
## Install packages system without recommanded
## -----------------------------------------------------------------------------
String::separateLine
Package::install --yes --quiet ${m_INSTALL_PACKAGES_SYSTEM_NORECOMMENDS}
Console::waitUser

## -----------------------------------------------------------------------------
## Install packages apps
## -----------------------------------------------------------------------------
String::separateLine
Package::install --yes --quiet ${m_INSTALL_PACKAGES_APP}
Console::waitUser

## -----------------------------------------------------------------------------
## Configures .bashrc and .bash_aliases
## -----------------------------------------------------------------------------
String::separateLine
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/pkg/bashrc/pkg.sh"
String::notice "Configuring .bashrc and .bash_aliases ..."
BashRC::configure
iReturn=$?
String::notice -n "Configures .bashrc and .bash_aliases:"
String::checkReturnValueForTruthiness ${iReturn}
Console::waitUser

## -----------------------------------------------------------------------------
## Configure swap
## -----------------------------------------------------------------------------
String::separateLine
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/pkg/swap/pkg.sh"
String::notice "Configuring swap ..."
Swap::configure
iReturn=$?
String::notice -n "Configure swap:"
String::checkReturnValueForTruthiness ${iReturn}
Console::waitUser

## -----------------------------------------------------------------------------
## Logwatch
## -----------------------------------------------------------------------------
String::separateLine
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/pkg/logwatch/pkg.sh"
String::notice "Configuring logwatch ..."
LogWatch::configure
iReturn=$?
String::notice -n "Configure logwatch:"
String::checkReturnValueForTruthiness ${iReturn}
Console::waitUser

## -----------------------------------------------------------------------------
## Vim
## -----------------------------------------------------------------------------
String::separateLine
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/pkg/vimrc/pkg.sh"
String::notice "Updating Vim ..."
VimRC::configure
iReturn=$?
String::notice -n "Configure vimrc.local:"
String::checkReturnValueForTruthiness ${iReturn}
Console::waitUser

## -----------------------------------------------------------------------------
## Fail2ban
## -----------------------------------------------------------------------------
String::separateLine
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/pkg/fail2ban/pkg.sh"
String::notice "Updating fail2ban ..."
Fail2Ban::configure
iReturn=$?
String::notice -n "Configure fail2ban:"
String::checkReturnValueForTruthiness ${iReturn}
Console::waitUser

## -----------------------------------------------------------------------------
## Mlocate
## -----------------------------------------------------------------------------
String::separateLine
Install::updateMlocate
Console::waitUser

## -----------------------------------------------------------------------------
## Optimize SSD
## -----------------------------------------------------------------------------
String::separateLine
# shellcheck source=/dev/null
. "${m_DIR_APP}/install/pkg/ssd/pkg.sh"
String::notice "Optimizing SSD ..."
SSD::optimizeSSD
iReturn=$?
String::notice -n "Optimize SSD:"
String::checkReturnValueForTruthiness ${iReturn}
Console::waitUser

## -----------------------------------------------------------------------------
## END
## -----------------------------------------------------------------------------
String::notice "Now is: $(date -R)"
exit 0
