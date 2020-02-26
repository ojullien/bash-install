## -----------------------------------------------------------------------------
## Linux Scripts.
## Install app configuration file.
##
## @package ojullien\bash\app\install
## @license MIT <https://github.com/ojullien/bash-install/blob/master/LICENSE>
## -----------------------------------------------------------------------------

# Remove these 3 lines once you have configured this file
echo "The 'app/install/config.sh' file is not configured !!!"
String::error "The 'app/install/config.sh' file is not configured !!!"
exit 3

## -----------------------------------------------------------------------------
## User other than root for whom we need to configure
## .bashrc, .bash_aliases and vim
## -----------------------------------------------------------------------------
readonly m_INSTALL_USERS=("<user>") # You may want to update this !!!

## -----------------------------------------------------
## Packages
## -----------------------------------------------------
readonly m_INSTALL_PACKAGES_FIRST="lsb-release"
readonly m_INSTALL_PACKAGES_PURGE="vim-tiny"
readonly m_INSTALL_PACKAGES_SYSTEM="dkms build-essential util-linux deborphan localepurge hdparm htop ntp tzdata ntpdate debsums software-properties-common"
readonly m_INSTALL_PACKAGES_SYSTEM_NORECOMMENDS="--no-install-recommends smartmontools"
readonly m_INSTALL_PACKAGES_APP="vim fail2ban ftp mlocate chkrootkit logwatch"

## -----------------------------------------------------------------------------
## Trace
## -----------------------------------------------------------------------------
Install::trace() {
    String::separateLine
    String::notice "App configuration: Install"
    String::notice "\tPackages to install:"
    String::notice  "\t\t${m_INSTALL_PACKAGES_SYSTEM}"
    String::notice  "\t\t${m_INSTALL_PACKAGES_SYSTEM_NORECOMMENDS}"
    String::notice  "\t\t${m_INSTALL_PACKAGES_APP}"
    String::notice "\tPackages to uninstall:"
    String::notice  "\t\t${m_INSTALL_PACKAGES_PURGE}"
    return 0
}
